{
  "log": {
    "disabled": true,
    "level": "panic"
  },
  "dns": {
    "servers": [
      {
        "tag": "Internet-dns",
        "address": "https://94.140.14.14/dns-query",
        "strategy": "prefer_ipv4",
        "detour": "Internet"
      },
      {
        "tag": "Best Latency-dns",
        "address": "https://94.140.14.14/dns-query",
        "strategy": "prefer_ipv4",
        "detour": "Best Latency"
      },
      {
        "tag": "direct-dns",
        "address": "tcp://8.8.8.8",
        "strategy": "prefer_ipv4",
        "detour": "direct"
      },
      {
        "tag": "block-dns",
        "address": "rcode://success"
      }
    ],
    "rules": [
      {
        "domain": [
          "homa.cybsecguru.com",
          "all-v6.cybsecguru.com"
        ],
        "server": "direct-dns",
        "rewrite_ttl": 20
      },
      {
        "domain_regex": [
          ".*\\.ir$",
          ".*\\.xn--mgba3a4f16a$"
        ],
        "server": "direct-dns",
        "rewrite_ttl": 20
      },
      {
        "outbound": "Internet",
        "server": "Internet-dns",
        "rewrite_ttl": 20
      },
      {
        "outbound": "Best Latency",
        "server": "Best Latency-dns",
        "rewrite_ttl": 20
      },
      {
        "outbound": "direct",
        "server": "direct-dns",
        "rewrite_ttl": 20
      },
      {
        "outbound": "any",
        "server": "direct-dns",
        "rewrite_ttl": 20
      },
      {
        "inbound": "tun-in",
        "query_type": [
          "A",
          "AAAA"
        ],
        "server": "Best Latency-dns",
        "disable_cache": true,
        "rewrite_ttl": 20
      }
    ],
    "strategy": "prefer_ipv4",
    "independent_cache": true
  },
  "inbounds": [
    {
      "type": "tun",
      "tag": "tun-in",
      "mtu": 9000,
      "address": [
        "172.18.0.1/30",
        "fdfe:dcba:9876::1/126"
      ],
      "auto_route": true,
      "strict_route": true,
      "route_exclude_address": [
        "192.168.0.0/16",
        "fc00::/7"
      ],
      "stack": "mixed",
      "sniff": true,
      "sniff_override_destination": true,
      "domain_strategy": "prefer_ipv4"
    },
    {
      "type": "mixed",
      "tag": "mixed-in",
      "listen": "0.0.0.0",
      "listen_port": 4040,
      "sniff": true,
      "sniff_override_destination": true,
      "domain_strategy": "prefer_ipv4"
    }
  ],
  "outbounds": [
    {
      "type": "selector",
      "tag": "Internet",
      "outbounds": [
        "Best Latency",
        "🇸🇪 A",
        "🇸🇪 B",
        "🇸🇪 C",
        "🇸🇪 D"
      ]
    },
    {
      "type": "hysteria2",
      "tag": "🇸🇪 A",
      "server": "150.241.77.178",
      "server_port": 22233,
      "obfs": {
        "type": "salamander",
        "password": "108ecb57dc7a7694"
      },
      "password": "36a78e623720090d"
    },
    {
      "type": "hysteria2",
      "tag": "🇸🇪 B",
      "server": "150.241.77.182",
      "server_port": 11122,
      "obfs": {
        "type": "salamander",
        "password": "64da92df31fc63c1"
      },
      "password": "c76f08e20fb6368b"
    },
    {
      "type": "hysteria2",
      "tag": "🇸🇪 C",
      "server": "150.241.77.174",
      "server_port": 33344,
      "obfs": {
        "type": "salamander",
        "password": "f64fc97d84ec14cf"
      },
      "password": "5a072771500faceb"
    },
    {
      "type": "hysteria2",
      "tag": "🇸🇪 D",
      "server": "172.233.81.57",
      "server_port": 443,
      "obfs": {
        "type": "salamander",
        "password": "YTVjNWFjYzExOTIzNzQyOQ=="
      },
      "password": "1486bfa6-1c4c-456d-b055-c9760f911385"
    },
    {
      "type": "direct",
      "tag": "direct"
    },
    {
      "type": "block",
      "tag": "block"
    },
    {
      "type": "dns",
      "tag": "dns-out"
    }
  ],
  "route": {
    "rules": [
      {
        "port": 53,
        "outbound": "dns-out"
      },
      {
        "network": "tcp",
        "port": 853,
        "outbound": "block"
      },
      {
        "network": "udp",
        "port": [
          443,
          853
        ],
        "outbound": "block"
      },
      {
        "protocol": "stun",
        "outbound": "block"
      },
      {
        "source_ip_cidr": [
          "224.0.0.0/3",
          "ff00::/8"
        ],
        "ip_cidr": [
          "224.0.0.0/3",
          "ff00::/8"
        ],
        "outbound": "block"
      },
      {
        "ip_is_private": true,
        "outbound": "direct"
      },
      {
        "domain_regex": [
          ".*\\.i﻿r$",
          ".*\\.xn--mgba3a4f16a$"
        ],
        "outbound": "direct"
      }
    ],
    "final": "Internet",
    "auto_detect_interface": true,
    "override_android_vpn": true
  },
  "experimental": {
    "cache_file": {
      "enabled": true,
      "path": "cache.db",
      "cache_id": "saeed"
    }
  }
}
