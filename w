{
  "dns": {
    "final": "local-dns",
    "rules": [
      {
        "clash_mode": "Global",
        "server": "proxy-dns",
        "source_ip_cidr": [
          "172.19.0.0/30"
        ]
      },
      {
        "server": "proxy-dns",
        "source_ip_cidr": [
          "172.19.0.0/30"
        ]
      },
      {
        "clash_mode": "Direct",
        "server": "direct-dns"
      },
      {
        "rule_set": [
          "geosite-ir"
        ],
        "server": "direct-dns"
      }
    ],
    "servers": [
      {
        "address": "tcp://8.8.8.8",
        "address_resolver": "local-dns",
        "detour": "proxy",
        "tag": "proxy-dns"
      },
      {
        "address": "local",
        "detour": "direct",
        "tag": "local-dns"
      },
      {
        "address": "rcode://success",
        "tag": "block"
      },
      {
        "address": "tcp://8.8.8.8",
        "detour": "direct",
        "tag": "direct-dns"
      }
    ],
    "strategy": "prefer_ipv4"
  },
  "inbounds": [
    {
      "address": [
        "172.19.0.1/30",
        "fdfe:dcba:9876::1/126"
      ],
      "auto_route": true,
      "endpoint_independent_nat": false,
      "mtu": 9000,
      "platform": {
        "http_proxy": {
          "enabled": true,
          "server": "127.0.0.1",
          "server_port": 2080
        }
      },
      "sniff": true,
      "stack": "system",
      "strict_route": false,
      "type": "tun"
    },
    {
      "listen": "127.0.0.1",
      "listen_port": 2080,
      "sniff": true,
      "type": "mixed",
      "users": []
    }
  ],
  "outbounds": [
    {
      "outbounds": [
        "auto",
        "direct",
        "🇱🇹-VPNineh1",
        "🇱🇹-VPNineh2",
        "🇱🇹-VPNineh3",
        "🇱🇹-VPNineh4",
        "🇱🇹-VPNineh5",
        "🇱🇹-VPNineh6"
      ],
      "tag": "proxy",
      "type": "selector"
    },
    {
      "interval": "10m",
      "outbounds": [
        "🇱🇹-VPNineh1",
        "🇱🇹-VPNineh2",
        "🇱🇹-VPNineh3",
        "🇱🇹-VPNineh4",
        "🇱🇹-VPNineh5",
        "🇱🇹-VPNineh6"
      ],
      "tag": "auto",
      "tolerance": 50,
      "type": "urltest",
      "url": "http://www.gstatic.com/generate_204"
    },
    {
      "tag": "direct",
      "type": "direct"
    },
    {
      "tag": "dns-out",
      "type": "dns"
    },
    {
      "tag": "block",
      "type": "block"
    },
    {
      "obfs": {
        "password": "f64fc97d84ec14cf",
        "type": "salamander"
      },
      "password": "5a072771500faceb",
      "server": "150.241.77.174",
      "server_port": 33344,
      "tag": "🇱🇹-VPNineh1",
      "tls": {
        "enabled": true,
        "insecure": true,
        "server_name": "www.google.com"
      },
      "type": "hysteria2"
    },
    {
      "type": "hysteria2",
      "tag": "🇱🇹-VPNineh2",
      "tls": {
        "enabled": true,
        "insecure": true,
        "server_name": "www.google.com"
      },
      "server": "172.233.81.57",
      "server_port": 443,
      "obfs": {
        "type": "salamander",
        "password": "YTVjNWFjYzExOTIzNzQyOQ=="
      },
      "password": "1486bfa6-1c4c-456d-b055-c9760f911385"
    },
    {
      "obfs": {
        "password": "108ecb57dc7a7694",
        "type": "salamander"
      },
      "password": "36a78e623720090d",
      "server": "150.241.77.178",
      "server_port": 22233,
      "tag": "🇱🇹-VPNineh3",
      "tls": {
        "enabled": true,
        "insecure": true,
        "server_name": "www.google.com"
      },
      "type": "hysteria2"
    },
    {
      "obfs": {
        "password": "108ecb57dc7a7694",
        "type": "salamander"
      },
      "password": "36a78e623720090d",
      "server": "2a0b:4140:e6c6::2",
      "server_port": 22233,
      "tag": "🇱🇹-VPNineh4",
      "tls": {
        "enabled": true,
        "insecure": true,
        "server_name": "www.google.com"
      },
      "type": "hysteria2"
    },
    {
      "obfs": {
        "password": "64da92df31fc63c1",
        "type": "salamander"
      },
      "password": "c76f08e20fb6368b",
      "server": "150.241.77.182",
      "server_port": 11122,
      "tag": "🇱🇹-VPNineh5",
      "tls": {
        "enabled": true,
        "insecure": true,
        "server_name": "www.google.com"
      },
      "type": "hysteria2"
    },
    {
      "obfs": {
        "password": "64da92df31fc63c1",
        "type": "salamander"
      },
      "password": "c76f08e20fb6368b",
      "server": "2a0b:4140:e6c7::2",
      "server_port": 11122,
      "tag": "🇱🇹-VPNineh6",
      "tls": {
        "enabled": true,
        "insecure": true,
        "server_name": "www.google.com"
      },
      "type": "hysteria2"
    }
  ],
  "route": {
    "auto_detect_interface": true,
    "final": "proxy",
    "rule_set": [
      {
        "download_detour": "direct",
        "format": "binary",
        "tag": "geosite-ads",
        "type": "remote",
        "url": "https://testingcf.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@sing/geo/geosite/category-ads-all.srs"
      },
      {
        "download_detour": "direct",
        "format": "binary",
        "tag": "geosite-ir",
        "type": "remote",
        "url": "https://testingcf.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@sing/geo/geosite/category-ir.srs"
      },
      {
        "download_detour": "direct",
        "format": "binary",
        "tag": "geoip-ir",
        "type": "remote",
        "url": "https://testingcf.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@sing/geo/geoip/ir.srs"
      }
    ],
    "rules": [
      {
        "clash_mode": "Direct",
        "outbound": "direct"
      },
      {
        "clash_mode": "Global",
        "outbound": "proxy"
      },
      {
        "outbound": "dns-out",
        "protocol": "dns"
      },
      {
        "outbound": "direct",
        "rule_set": [
          "geoip-ir",
          "geosite-ir"
        ]
      },
      {
        "outbound": "block",
        "rule_set": [
          "geosite-ads"
        ]
      }
    ]
  }
}
