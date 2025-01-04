{
  "log": {
    "disabled": true,
    "level": "panic"
  },
  "dns": {
    "servers": [
      {
        "tag": "Internet-dns",
        "address": "udp://1.1.1.1",
        "strategy": "prefer_ipv4",
        "detour": "Internet"
      },
      {
        "tag": "Best Latency-dns",
        "address": "fakeip",
        "strategy": "prefer_ipv4",
        "detour": "Best Latency"
      },
      {
        "tag": "direct-dns",
        "address": "udp://1.1.1.1",
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
        "domain_suffix": [
          "all-v4.dgi000.store",
          "all-v6.dgi000.store"
        ],
        "server": "direct-dns",
        "rewrite_ttl": 20
      },
      {
        "domain": "www.gstatic.com",
        "server": "Internet-dns",
        "rewrite_ttl": 3000
      },
      {
        "network": "udp",
        "port": 443,
        "server": "block-dns",
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
        "rule_set": "geosite-ir",
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
      }
    ],
    "final": "Internet-dns",
    "fakeip": {
      "enabled": true,
      "inet4_range": "198.18.0.0/15",
      "inet6_range": "fc00::/18"
    },
    "strategy": "prefer_ipv4",
    "disable_expire": true
  },
  "inbounds": [
    {
      "type": "tun",
      "tag": "tun-in",
      "interface_name": "tun0",
      "mtu": 9000,
      "inet4_address": "172.19.0.1/30",
      "inet6_address": "fdfe:dcba:9876::1/126",
      "auto_route": true,
      "strict_route": true,
      "stack": "mixed",
      "sniff": true,
      "sniff_override_destination": true,
      "domain_strategy": "prefer_ipv4"
    },
    {
      "type": "mixed",
      "tag": "mixed-in",
      "listen": "0.0.0.0",
      "listen_port": 2080,
      "sniff": true,
      "sniff_override_destination": true,
      "domain_strategy": "prefer_ipv4"
    },
    {
      "type": "direct",
      "tag": "dns-in",
      "listen": "0.0.0.0",
      "listen_port": 6450,
      "sniff": true,
      "sniff_override_destination": true,
      "domain_strategy": "prefer_ipv4",
      "override_address": "1.1.1.1",
      "override_port": 53
    }
  ],
"outbounds": [
		{
			"type": "selector",
			"tag": "Internet",
			"outbounds": [
				"Best Latency",
                        "Farbod"
			]
		},
		{
			"type": "urltest",
			"tag": "Best Latency",
			"outbounds": [
                        "Farbod"

			],
			"url": "http://www.gstatic.com/generate_204",
			"interval": "3m0s",
			"tolerance": 1,
			"idle_timeout": "9m0s"
		},
{
  "server": "77.91.87.167",
  "server_port": 2087,
  "tag": "Farbod",
  "type": "hysteria2",
  "password": "04bb42227f7c629c",
  "obfs": {
    "password": "fd784f88798796c1",
    "type": "salamander"
  },
  "tls": {
    "enabled": true,
    "server_name": "www.google.com",
    "insecure": true
  }
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
        "inbound": "dns-in",
        "outbound": "dns-out"
      },
      {
        "port": 53,
        "outbound": "dns-out"
      },
      {
        "network": "udp",
        "port": 443,
        "outbound": "block"
      },
      {
        "protocol": "stun",
        "outbound": "block"
      },
      {
        "ip_cidr": [
          "10.10.34.34",
          "10.10.34.35",
          "10.10.34.36"
        ],
        "outbound": "block"
      },
      {
        "ip_is_private": true,
        "outbound": "direct"
      },
      {
        "domain_regex": [
          ".*\\.ir$",
          ".*\\.xn--mgba3a4f16a$"
        ],
        "outbound": "direct"
      },
      {
        "rule_set": [
          "geoip-ir",
          "geosite-ir"
        ],
        "outbound": "direct"
      }
    ],
    "rule_set": [
      {
        "type": "remote",
        "tag": "geoip-ir",
        "format": "binary",
        "url": "https://raw.githubusercontent.com/Chocolate4U/Iran-sing-box-rules/rule-set/geoip-ir.srs",
        "download_detour": "direct",
        "update_interval": "168h0m0s"
      },
      {
        "type": "remote",
        "tag": "geosite-ir",
        "format": "binary",
        "url": "https://raw.githubusercontent.com/Chocolate4U/Iran-sing-box-rules/rule-set/geosite-ir.srs",
        "download_detour": "direct",
        "update_interval": "168h0m0s"
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
      "cache_id": "saeed",
      "store_fakeip": true,
      "store_rdrc": true,
      "rdrc_timeout": "168h0m0s"
    }
  }
}
