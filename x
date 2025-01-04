{
  "log": {
    "level": "warn",
    "output": "box.log",
    "timestamp": true
  },
  "dns": {
    "servers": [
      {
        "tag": "dns-remote",
        "address": "udp://9.9.9.9",
        "address_resolver": "dns-direct"
      },
      {
        "tag": "dns-trick-direct",
        "address": "https://sky.rethinkdns.com/",
        "detour": "direct-fragment"
      },
      {
        "tag": "dns-direct",
        "address": "9.9.9.9",
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
        "domain": "qoypua5rddvey8m0dco7",
        "server": "dns-direct"
      },
      {
        "domain": "www.google.com",
        "server": "dns-remote",
        "rewrite_ttl": 3000
      },
      {
        "rule_set": [
          "geoip-ir",
          "geosite-ir"
        ],
        "server": "dns-direct"
      }
    ],
    "final": "dns-remote",
 
    },
    "independent_cache": true
  },
  "inbounds": [
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
      "listen_port": 16450
    }
  ],
  "outbounds": [
    {
      "type": "selector",
      "tag": "select",
      "outbounds": [
        "auto",
                "WARP-MAIN",
                "WARP-WIW"
      ],
      "default": "auto"
    },
    {
      "type": "urltest",
      "tag": "auto",
      "outbounds": [
                "WARP-MAIN",
                "WARP-WIW"
      ],
      "url": "http://www.google.com/generate_204",
      "interval": "10m0s",
      "tolerance": 1,
      "idle_timeout": "30m0s"
    },
    {
            "tag": "WARP-MAIN",
            "type": "wireguard",
            "server": "162.159.195.237",
            "server_port": 3476,
            "local_address": [
                "172.16.0.2/32",
                "2606:4700:110:8735:bb29:91bc:1c82:aa73/128"
            ],
            "private_key": "4K8xIq18bN7h4TMDm7pCgoF/LFiJzfxW7OYiGBk3IFg=",
            "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
            "mtu": 1384,
            "reserved": [
                13,
                14,
                22
            ],
            "detour": "direct",
            "workers": 2
        },
        {
            "tag": "WARP-WIW",
            "type": "wireguard",
            "server": "188.114.99.25",
            "server_port": 942,
            "local_address": [
                "172.16.0.2/32",
                "2606:4700:110:8735:bb29:91bc:1c82:aa73/128"
            ],
            "private_key": "wM3VxOx9h7MClClmxyY6VwAC5Lm+Hz4xMew6QVqZPH0=",
            "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
            "mtu": 1384,
            "reserved": [
                39,
                99,
                249
            ],
            "detour": "WARP-MAIN",
            "workers": 2
        },
    {
      "type": "dns",
      "tag": "dns-out"
    },
    {
      "type": "direct",
      "tag": "direct"
    },
    {
      "type": "direct",
      "tag": "direct-fragment",
      "tls_fragment": {
        "enabled": true,
        "size": "20-50",
        "sleep": "1-1"
      }
    },
    {
      "type": "direct",
      "tag": "bypass"
    },
    {
      "type": "block",
      "tag": "block"
    }
  ],
  "route": {
    "rules": [
      {
        "rule_set": [
          "geoip-ir",
          "geosite-ir"
        ],
        "outbound": "direct"
      },
      {
        "inbound": "dns-in",
        "outbound": "dns-out"
      },
      {
        "port": 53,
        "outbound": "dns-out"
      },
      {
        "clash_mode": "Direct",
        "outbound": "direct"
      },
      {
        "clash_mode": "Global",
        "outbound": "select"
      }
    ],
    "rule_set": [
      {
        "type": "remote",
        "tag": "geoip-ir",
        "format": "binary",
        "url": "https://raw.githubusercontent.com/hiddify/hiddify-geo/rule-set/country/geoip-ir.srs",
        "update_interval": "120h0m0s"
      },
      {
        "type": "remote",
        "tag": "geosite-ir",
        "format": "binary",
        "url": "https://raw.githubusercontent.com/hiddify/hiddify-geo/rule-set/country/geosite-ir.srs",
        "update_interval": "120h0m0s"
      }
    ],
    "final": "select",
    "auto_detect_interface": true,
    "override_android_vpn": true
  },
  "experimental": {
    "cache_file": {
      "enabled": true,
      "path": "clash.db"
    },
    "clash_api": {
      "external_controller": "127.0.0.1:16756",
      "secret": "nsBiqt7UHNwPlJKM"
    }
  }
}
