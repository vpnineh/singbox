{
  "log": {
    "disabled": false,
    "level": "info",
    "timestamp": true
  },
  "dns": {
    "servers": [
      {
        "tag": "proxy_dns",
        "address": "tls://8.8.8.8/dns-query",
        "detour": "select"
      },
      {
        "tag": "local_dns",
        "address": "h3://223.5.5.5/dns-query",
        "detour": "direct"
      },
      {
        "tag": "reject",
        "address": "rcode://refused"
      },
      {
        "tag": "fake_ip",
        "address": "fakeip"
      }
    ],
    "rules": [
      {
        "outbound": "any",
        "server": "local_dns",
        "disable_cache": true
      },
      {
        "clash_mode": "Global",
        "server": "proxy_dns"
      },
      {
        "clash_mode": "Direct",
        "server": "local_dns"
      },
      {
        "rule_set": "geosite-cn",
        "server": "local_dns"
      },
      {
        "rule_set": "geosite-geolocation-!cn",
        "server": "proxy_dns"
      },
      {
        "rule_set": "geosite-geolocation-!cn",
        "query_type": [
          "A",
          "AAAA"
        ],
        "server": "fake_ip"
      }
    ],
    "final": "proxy_dns",
    "independent_cache": true,
    "fakeip": {
      "enabled": true,
      "inet4_range": "198.18.0.0/15",
      "inet6_range": "fc00::/18"
    }
  },
  "ntp": {
    "detour": "direct",
    "enabled": true,
    "server": "time.apple.com",
    "server_port": 123,
    "interval": "30m"
  },
  "inbounds": [
    {
      "sniff": true,
      "sniff_override_destination": true,
      "domain_strategy": "prefer_ipv4",
      "type": "tun",
      "inet4_address": "172.16.0.1/30",
      "inet6_address": "2001:0470:f9da:fdfa::1/64",
      "mtu": 9000,
      "auto_route": true,
      "strict_route": true,
      "endpoint_independent_nat": true
    }
  ],
  "outbounds": [
    {
      "type": "selector",
      "tag": "select",
      "outbounds": [
        "url-test",
        "@Freakconfig"
      ],
      "default": "url-test"
    },
    {
      "type": "urltest",
      "tag": "url-test",
      "outbounds": [
        "@Freakconfig"
      ],
      "url": "https://www.gstatic.com/generate_204",
      "interval": "3m",
      "tolerance": 50
    },
    {
      "type": "vless",
      "tag": "@Freakconfig",
      "server": "172.66.47.155",
      "server_port": 443,
      "uuid": "34a83286-ba4e-4f0a-ac08-77a95469eeaf",
      "tls": {
        "enabled": true,
        "utls": {
          "enabled": true,
          "fingerprint": "randomized"
        }
      },
      "transport": {
        "type": "ws",
        "headers": {
          "host": "pardazesh18.pages.dev"
        }
      }
    },
    {
      "type": "direct",
      "tag": "direct"
    },
    {
      "type": "block",
      "tag": "reject"
    },
    {
      "type": "dns",
      "tag": "dns_out"
    }
  ],
  "route": {
    "rules": [
      {
        "clash_mode": "Global",
        "outbound": "select"
      },
      {
        "clash_mode": "Direct",
        "outbound": "direct"
      },
      {
        "protocol": "dns",
        "outbound": "dns_out"
      },
      {
        "rule_set": "geosite-category-ads-all",
        "outbound": "reject"
      },
      {
        "rule_set": "geoip-cn",
        "outbound": "direct"
      },
      {
        "rule_set": "geosite-cn",
        "outbound": "direct"
      },
      {
        "ip_is_private": true,
        "outbound": "direct"
      },
      {
        "rule_set": "geosite-geolocation-!cn",
        "outbound": "select"
      }
    ],
    "rule_set": [
      {
        "type": "remote",
        "tag": "geoip-cn",
        "format": "binary",
        "url": "https://raw.githubusercontent.com/SagerNet/sing-geoip/rule-set/geoip-cn.srs",
        "download_detour": "select",
        "update_interval": "1d"
      },
      {
        "type": "remote",
        "tag": "geosite-cn",
        "format": "binary",
        "url": "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-cn.srs",
        "download_detour": "select",
        "update_interval": "1d"
      },
      {
        "type": "remote",
        "tag": "geosite-geolocation-!cn",
        "format": "binary",
        "url": "https://cdn.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@sing/geo/geosite/geolocation-!cn.srs",
        "download_detour": "select",
        "update_interval": "1d"
      },
      {
        "type": "remote",
        "tag": "geosite-category-ads-all",
        "format": "binary",
        "url": "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-category-ads-all.srs",
        "download_detour": "select",
        "update_interval": "1d"
      }
    ],
    "final": "select",
    "auto_detect_interface": true
  },
  "experimental": {
    "cache_file": {
      "enabled": true,
      "path": "cache.db"
    },
    "clash_api": {
      "external_controller": "127.0.0.1:9090"
    }
  }
}
