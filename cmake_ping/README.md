# ping工具

### 一、主要特色

- 使用cmake重构了ping工具的源码工程，能够直接编译出最简单的ping工具。
- 目前工程结构比较清晰明了，易于阅读源码

### 二、主要目的

- 查看ping工具里面是如何绑定自身的特定端口进行通信的，内在原理是如何
- 想要通过模仿内在指定端口转发的功能，改写modbus的通讯库

### 三、转发试验

- 1、目前的网络状态的情况
```bash
rk@localhost:~/pengzhikang$ ifconfig 
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.1.177  netmask 255.255.255.0  broadcast 10.0.1.255
        inet6 fe80::b4f5:91c6:5928:a878  prefixlen 64  scopeid 0x20<link>
        ether 6e:e8:43:36:6e:7c  txqueuelen 1000  (Ethernet)
        RX packets 135757  bytes 125066586 (125.0 MB)
        RX errors 0  dropped 121  overruns 0  frame 0
        TX packets 47791  bytes 4910035 (4.9 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 24  

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1  (Local Loopback)
        RX packets 12396  bytes 3435542 (3.4 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 12396  bytes 3435542 (3.4 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.191.5  netmask 255.255.255.0  broadcast 192.168.191.255
        inet6 fe80::e59c:e38a:ecf7:dd8c  prefixlen 64  scopeid 0x20<link>
        inet6 fe80::a3fa:4e85:5406:d4ac  prefixlen 64  scopeid 0x20<link>
        inet6 fe80::78a:2c86:ea36:c1bd  prefixlen 64  scopeid 0x20<link>
        ether 10:d0:7a:cb:25:35  txqueuelen 1000  (Ethernet)
        RX packets 348  bytes 60642 (60.6 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 500  bytes 60406 (60.4 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

rk@localhost:~/pengzhikang$ nmcli dev
DEVICE  TYPE      STATE      CONNECTION    
eth0    ethernet  connected  Auto Ethernet 
wlan0   wifi      connected  YunQiWIFI     
lo      loopback  unmanaged  --            
```
- 2、使用cmake_ping工具进行Ping试验
```bash
# 从eth0口去ping192.168.191.6，发现无法ping通，说明确实是指定了特定的网口收发信息
rk@localhost:~/pengzhikang/cmake_ping/bin$ sudo ./cmake_ping 192.168.191.6 -I eth0 -c 10
[sudo] password for rk: 
PING 192.168.191.6 (192.168.191.6) from 10.0.1.177 eth0: 56(84) bytes of data.

--- 192.168.191.6 ping statistics ---
10 packets transmitted, 0 received, 100% packet loss, time 8999ms
# 从wlan0口去ping192.168.191.6，可以ping通
rk@localhost:~/pengzhikang/cmake_ping/bin$ sudo ./cmake_ping 192.168.191.6 -I wlan0 -c 10
PING 192.168.191.6 (192.168.191.6) from 192.168.191.5 wlan0: 56(84) bytes of data.
64 bytes from 192.168.191.6: icmp_seq=3 ttl=64 time=13.1 ms
64 bytes from 192.168.191.6: icmp_seq=4 ttl=64 time=127 ms
64 bytes from 192.168.191.6: icmp_seq=5 ttl=64 time=107 ms
64 bytes from 192.168.191.6: icmp_seq=6 ttl=64 time=126 ms
64 bytes from 192.168.191.6: icmp_seq=7 ttl=64 time=54.6 ms
64 bytes from 192.168.191.6: icmp_seq=8 ttl=64 time=77.1 ms
64 bytes from 192.168.191.6: icmp_seq=9 ttl=64 time=97.2 ms
64 bytes from 192.168.191.6: icmp_seq=10 ttl=64 time=117 ms

--- 192.168.191.6 ping statistics ---
10 packets transmitted, 8 received, 20% packet loss, time 9011ms
rtt min/avg/max/mdev = 13.109/90.135/127.519/37.411 ms
# 从wlan0口去ping10.0.1.28，可以ping通（主要原因是该wifi热点是从10.0.1.1的局域网发出的
rk@localhost:~/pengzhikang/cmake_ping/bin$ sudo ./cmake_ping 10.0.1.28 -I wlan0 -c 10
PING 10.0.1.28 (10.0.1.28) from 192.168.191.5 wlan0: 56(84) bytes of data.
64 bytes from 10.0.1.28: icmp_seq=1 ttl=127 time=8.19 ms
64 bytes from 10.0.1.28: icmp_seq=2 ttl=127 time=66.8 ms
64 bytes from 10.0.1.28: icmp_seq=3 ttl=127 time=8.56 ms
64 bytes from 10.0.1.28: icmp_seq=4 ttl=127 time=10.1 ms
64 bytes from 10.0.1.28: icmp_seq=5 ttl=127 time=16.5 ms
64 bytes from 10.0.1.28: icmp_seq=6 ttl=127 time=8.69 ms
64 bytes from 10.0.1.28: icmp_seq=7 ttl=127 time=16.1 ms
64 bytes from 10.0.1.28: icmp_seq=8 ttl=127 time=5.80 ms
64 bytes from 10.0.1.28: icmp_seq=9 ttl=127 time=10.5 ms
64 bytes from 10.0.1.28: icmp_seq=10 ttl=127 time=10.6 ms

--- 10.0.1.28 ping statistics ---
10 packets transmitted, 10 received, 0% packet loss, time 9016ms
rtt min/avg/max/mdev = 5.805/16.216/66.885/17.189 ms
# 类似地，因为10.0.1.1的网段可以ping通www.baidu.com，所以wlan0也可以ping通www.baidu.com
```

### 四、目前的主要发现点

- ping.c中通过创建int probe_fd = socket(AF_INET, SOCK_DGRAM, 0)这样的套接字，然后通过setsockopt(probe_fd, SOL_SOCKET, SO_BINDTODEVICE, device, strlen(device)+1)让其绑定在device上，从而获取本地的ip地址。
- 后续的对icmp_sock使用bind(icmp_sock, (struct sockaddr*)&source, sizeof(source))进行绑定特定的本地网址，从而后续可以达到指定网口收发的目的。
- ping.c使用到了icmp_sock = socket(AF_INET, SOCK_RAW, IPPROTO_ICMP)，创建的是原始套接字，无法保证tcp的套接字是否可以去使用上述方法去绑定。因此有待验证。

### 五、github工程下载

```bash
git clone https://github.com/pengzhikang/UnixNetLearning.git
cd cmake_ping
chmod +x run.sh
./run.sh
```