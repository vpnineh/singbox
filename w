{
  "log": {
    "disabled": true,
    "level": "panic"
  },
  "dns": {
      "servers": [
        {
          "tag": "dns-remote",
          "address": "tcp://8.8.4.4",
          "address_resolver": "dns-direct"
        },
        {
          "tag": "dns-trick-direct",
          "address": "https://sky.rethinkdns.com/",
          "detour": "direct-fragment"
        },
        {
          "tag": "dns-direct",
          "address": "tcp://8.8.4.4",
          "address_resolver": "dns-local",
          "detour": "direct"
        },
        {
          "tag": "dns-local",
          "address": "local",
          "detour": "direct"
        },
        {
          "tag": "dns-block",
          "address": "rcode://success"
        }
      ],
      "rules": [
        {
          "domain_suffix": ".ir",
          "geosite": "ir",
          "server": "dns-direct"
        },
        {
          "domain": "cp.cloudflare.com",
          "server": "dns-remote",
          "rewrite_ttl": 3000
        }
      ],
      "final": "dns-remote",
      "static_ips": {
        "sky.rethinkdns.com": [
          "188.114.96.3",
          "188.114.97.3",
          "2a06:98c1:3120::3",
          "2a06:98c1:3121::3",
          "104.18.203.232",
          "104.18.202.232",
          "188.114.96.6",
          "188.114.97.6",
          "2a06:98c1:3121::3",
          "2a06:98c1:3120::3"
        ]
      },
      "independent_cache": true
    },
    "inbounds": [
      {
        "type": "tun",
        "tag": "tun-in",
        "mtu": 9000,
        "inet4_address": "172.19.0.1/28",
        "inet6_address": "fdfe:dcba:9876::1/126",
        "auto_route": true,
        "strict_route": true,
        "endpoint_independent_nat": true,
        "sniff": true,
        "sniff_override_destination": true
      },
      {
        "type": "mixed",
        "tag": "mixed-in",
        "listen": "127.0.0.1",
        "listen_port": 2334,
        "sniff": true,
        "sniff_override_destination": true
      },
      {
        "type": "direct",
        "tag": "dns-in",
        "listen": "127.0.0.1",
        "listen_port": 6440,
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
                        "1",
                        "2",
                        "3",
                        "4",
                        "5"

			]
		},
		{
			"type": "urltest",
			"tag": "Best Latency",
			"outbounds": [
                        "1",
                        "2",
                        "3",
                        "4",
                        "5"
			],
			"url": "http://www.google.com/generate_204",
			"interval": "3m0s",
			"tolerance": 1,
			"idle_timeout": "9m0s"
		},
{
        "type": "wireguard",
        "tag": "1",
        "local_address": [
          "172.16.0.2/24",
          "2606:4700:110:8056:6ec9:563a:d8e7:5097/128"
        ],
        "private_key": "MCxYQIHkEGeB/FGvd2/+rCJEvwcYN1e7hF6vtJaauH4\u003d",
        "server": "2606:4700:d0::1e55:38fd:b29e:4ced",
        "server_port": 0,
        "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo\u003d",
        "reserved": "bfY2",
        "mtu": 1330,
        "fake_packets": "5-10",
        "fake_packets_size": "40-100",
        "fake_packets_delay": "20-250"
      },
   {
        "type": "wireguard",
        "tag": "2",
        "detour": "1",
        "local_address": [
          "10.2.0.2/32"
        ],
        "private_key": "aLACvfzNbE8WeBnF/eC18mPR0N1dry4wxqZGcnACAkU=",
        "server": "185.177.126.140",
        "server_port": 51820,
        "peer_public_key": "ROYne+FuXzmkdjo1qgSP+7YtkziVekGbmI7ie+dwbwA=",
        "mtu": 1280
      },
      {
        "type": "wireguard",
        "tag": "3",
        "detour": "1",
        "local_address": [
          "10.2.0.2/32"
        ],
        "private_key": "0IuEcoh2yaT38g7Ai4k7wQJBe+1PTM9LXSv4/fgwXl4=",
        "server": "185.177.126.14",
        "server_port": 51820,
        "peer_public_key": "wweP0YfxgQTCes+5UoXfhLbWXvHXGnwQkozFzvBA/i4=",
        "mtu": 1280
      },
    {
      "type": "wireguard",
      "tag": "4",
      "detour": "1",
      "local_address": [
        "172.16.0.2/24",
        "2606:4700:110:8710:cb04:5241:3490:26fa/128"
      ],
      "private_key": "aD1X77cNa/W8Qhi41DawRZjNLT88mqvBX6TGwm0oc2E=",
      "server": "188.114.97.170",
      "server_port": 5956,
      "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
      "reserved": "w4uU",
      "mtu": 1280
    },
  {
        "type": "wireguard",
        "tag": "5",
        "detour": "1",
        "local_address": [
          "10.2.0.2/32"
        ],
        "private_key": "2GupREfHuyqAAXYIV+IDKlRaQtok6P1yBmN0cnq0+Wo=",
        "server": "45.14.71.5",
        "server_port": 51820,
        "peer_public_key": "E5wPCWdLcrvCn8DI8/vetPVrOyIKFMpdgdhrVsTUdBU=",
        "mtu": 1280
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
