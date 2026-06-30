Project: 'P3' created on 2026-06-20
Author: John Doe <john.doe@example.com>

No project description was given

Manual FRR setup with vtysh

If you want to configure Part 3 by hand, open the router console and run `vtysh`, then paste the block for the router you are working on.

Router 1 (route reflector)

configure terminal
hostname _ibenaait-1
no ipv6 forwarding
interface lo
 ip address 1.1.1.1/32
 ip ospf area 0
exit
interface eth0
 ip address 10.1.1.1/30
 ip ospf area 0
exit
interface eth1
 ip address 10.1.1.5/30
 ip ospf area 0
exit
interface eth2
 ip address 10.1.1.9/30
 ip ospf area 0
exit
router ospf
 ospf router-id 1.1.1.1
 network 1.1.1.1/32 area 0
 network 10.1.1.0/30 area 0
 network 10.1.1.4/30 area 0
 network 10.1.1.8/30 area 0
exit
router bgp 1
 bgp router-id 1.1.1.1
 bgp cluster-id 1.1.1.1
 no bgp default ipv4-unicast
 bgp log-neighbor-changes
 neighbor 1.1.1.2 remote-as 1
 neighbor 1.1.1.2 update-source lo
 neighbor 1.1.1.3 remote-as 1
 neighbor 1.1.1.3 update-source lo
 neighbor 1.1.1.4 remote-as 1
 neighbor 1.1.1.4 update-source lo
 address-family l2vpn evpn
  neighbor 1.1.1.2 activate
  neighbor 1.1.1.2 route-reflector-client
  neighbor 1.1.1.3 activate
  neighbor 1.1.1.3 route-reflector-client
  neighbor 1.1.1.4 activate
  neighbor 1.1.1.4 route-reflector-client
 exit-address-family
exit
end
write memory

Router 2

configure terminal
hostname _ibenaait-2
no ipv6 forwarding
interface lo
 ip address 1.1.1.2/32
 ip ospf area 0
exit
interface eth0
 ip address 10.1.1.2/30
 ip ospf area 0
exit
router ospf
 ospf router-id 1.1.1.2
 network 1.1.1.2/32 area 0
 network 10.1.1.0/30 area 0
exit
router bgp 1
 bgp router-id 1.1.1.2
 no bgp default ipv4-unicast
 bgp log-neighbor-changes
 neighbor 1.1.1.1 remote-as 1
 neighbor 1.1.1.1 update-source lo
 address-family l2vpn evpn
  neighbor 1.1.1.1 activate
  advertise-all-vni
 exit-address-family
exit
end
write memory

Router 3

configure terminal
hostname _ibenaait-3
no ipv6 forwarding
interface lo
 ip address 1.1.1.3/32
 ip ospf area 0
exit
interface eth0
 ip address 10.1.1.6/30
 ip ospf area 0
exit
router ospf
 ospf router-id 1.1.1.3
 network 1.1.1.3/32 area 0
 network 10.1.1.4/30 area 0
exit
router bgp 1
 bgp router-id 1.1.1.3
 no bgp default ipv4-unicast
 bgp log-neighbor-changes
 neighbor 1.1.1.1 remote-as 1
 neighbor 1.1.1.1 update-source lo
 address-family l2vpn evpn
  neighbor 1.1.1.1 activate
  advertise-all-vni
 exit-address-family
exit
end
write memory

Router 4

configure terminal
hostname _ibenaait-4
no ipv6 forwarding
interface lo
 ip address 1.1.1.4/32
 ip ospf area 0
exit
interface eth0
 ip address 10.1.1.10/30
 ip ospf area 0
exit
router ospf
 ospf router-id 1.1.1.4
 network 1.1.1.4/32 area 0
 network 10.1.1.8/30 area 0
exit
router bgp 1
 bgp router-id 1.1.1.4
 no bgp default ipv4-unicast
 bgp log-neighbor-changes
 neighbor 1.1.1.1 remote-as 1
 neighbor 1.1.1.1 update-source lo
 address-family l2vpn evpn
  neighbor 1.1.1.1 activate
  advertise-all-vni
 exit-address-family
exit
end
write memory