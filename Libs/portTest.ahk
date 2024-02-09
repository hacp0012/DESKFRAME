test := TestPort("127.0.0.1", "9090")
If test
	MsgBox, % test
Else
	MsgBox, Connected.

TestPort(ip, port) {
	; Global socket
	FD_READ					:= 1
	FD_CLOSE				:= 32 
	FD_CONNECT				:= 20
	AF_INET					:= 2
	SOCK_STREAM 			:= 1
	IPPROTO_TCP				:= 6
	SizeOfSocketAddress 	:= 16

	VarSetCapacity(wsaData, 32)
	result := DllCall("Ws2_32\WSAStartup", "UShort", 0x0002, "UInt", &wsaData)
	if ErrorLevel
		Return "WSAStartup could not be called."

	if result  ; Non-zero, which means it failed (most Winsock functions return 0 upon success).
		Return "WSAStartup failed. " . DllCall("Ws2_32\WSAGetLastError")

	socket := DllCall("Ws2_32\socket", "Int", AF_INET, "Int", SOCK_STREAM, "Int", IPPROTO_TCP)
	if socket = -1
	{
		CleanUpConnection()
		Return DllCall("Ws2_32\WSAGetLastError")
	}

	socket := DllCall("Ws2_32\socket", "Int", AF_INET, "Int", SOCK_STREAM, "Int", IPPROTO_TCP)
	if socket = -1
	{
		CleanUpConnection()
		Return DllCall("Ws2_32\WSAGetLastError")
	}

	VarSetCapacity(SocketAddress, SizeOfSocketAddress, 0)
	translatedIP := DllCall("Ws2_32\inet_addr", "Str", ip)

	NumPut(2, SocketAddress, 0 "UShort")
	NumPut((DllCall("Ws2_32\htons", "UShort", port)), SocketAddress, 2, "UShort")
	NumPut(translatedIP, SocketAddress, 4, "UInt")

	; Attempt connection:
	if DllCall("Ws2_32\connect", "UInt", socket, "UInt", &SocketAddress, "Int", SizeOfSocketAddress)
	{
		CleanUpConnection()
		return DllCall("Ws2_32\WSAGetLastError")
	}

	Return 0
}

CleanUpConnection() {
	DllCall("Ws2_32\closesocket", UInt, port)
}