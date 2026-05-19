// 国内DNS服务器
const domesticNameservers = [
  "https://223.5.5.5/dns-query", // 阿里DoH
  "https://doh.pub/dns-query" // 腾讯DoH，因腾讯云即将关闭免费版IP访问，故用域名
];
// 国外DNS服务器
const foreignNameservers = [
  "https://cloudflare-dns.com/dns-query", // CloudflareDNS
  "https://77.88.8.8/dns-query", //YandexDNS
  "https://8.8.4.4/dns-query#ecs=1.1.1.1/24&ecs-override=true", // GoogleDNS
  "https://208.67.222.222/dns-query#ecs=1.1.1.1/24&ecs-override=true", // OpenDNS
  "https://9.9.9.9/dns-query", //Quad9DNS
];
// DNS配置
const dnsConfig = {
  "enable": true,
  "listen": "0.0.0.0:1053",
  // "ipv6": true,
  "prefer-h3": false,
  "respect-rules": true,
  "use-system-hosts": false,
  "cache-algorithm": "arc",
  "enhanced-mode": "fake-ip",
  "fake-ip-range": "198.18.0.1/16",
  "fake-ip-filter": [
    // 本地主机/设备
    "+.lan",
    "+.local",
    // // Windows网络出现小地球图标
    "+.msftconnecttest.com",
    "+.msftncsi.com",
    // QQ快速登录检测失败
    "localhost.ptlogin2.qq.com",
    "localhost.sec.qq.com",
    // 微信快速登录检测失败
    "localhost.work.weixin.qq.com"
  ],
  "default-nameserver": ["223.5.5.5", "1.2.4.8"],
  "nameserver": [...foreignNameservers],
  "proxy-server-nameserver": [...domesticNameservers],
  "direct-nameserver": [...domesticNameservers],
  "direct-nameserver-follow-policy": false,
  "nameserver-policy": {
    "geosite:cn": domesticNameservers
  }
};
// 规则集通用配置
const ruleProviderCommon = {
  "type": "http",
  "format": "yaml",
  "interval": 86400
};
// 规则集配置
const ruleProviders = {
  "reject": {
    ...ruleProviderCommon,
    "behavior": "domain",
    "url": "https://fastly.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/reject.txt",
    "path": "./ruleset/loyalsoldier/reject.yaml"
  },
  "icloud": {
    ...ruleProviderCommon,
    "behavior": "domain",
    "url": "https://fastly.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/icloud.txt",
    "path": "./ruleset/loyalsoldier/icloud.yaml"
  },
  "apple": {
    ...ruleProviderCommon,
    "behavior": "domain",
    "url": "https://fastly.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/apple.txt",
    "path": "./ruleset/loyalsoldier/apple.yaml"
  },
  "google": {
    ...ruleProviderCommon,
    "behavior": "domain",
    "url": "https://fastly.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/google.txt",
    "path": "./ruleset/loyalsoldier/google.yaml"
  },
  "proxy": {
    ...ruleProviderCommon,
    "behavior": "domain",
    "url": "https://fastly.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/proxy.txt",
    "path": "./ruleset/loyalsoldier/proxy.yaml"
  },
  "direct": {
    ...ruleProviderCommon,
    "behavior": "domain",
    "url": "https://fastly.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/direct.txt",
    "path": "./ruleset/loyalsoldier/direct.yaml"
  },
  "private": {
    ...ruleProviderCommon,
    "behavior": "domain",
    "url": "https://fastly.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/private.txt",
    "path": "./ruleset/loyalsoldier/private.yaml"
  },
  "gfw": {
    ...ruleProviderCommon,
    "behavior": "domain",
    "url": "https://fastly.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/gfw.txt",
    "path": "./ruleset/loyalsoldier/gfw.yaml"
  },
  "tld-not-cn": {
    ...ruleProviderCommon,
    "behavior": "domain",
    "url": "https://fastly.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/tld-not-cn.txt",
    "path": "./ruleset/loyalsoldier/tld-not-cn.yaml"
  },
  "telegramcidr": {
    ...ruleProviderCommon,
    "behavior": "ipcidr",
    "url": "https://fastly.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/telegramcidr.txt",
    "path": "./ruleset/loyalsoldier/telegramcidr.yaml"
  },
  "cncidr": {
    ...ruleProviderCommon,
    "behavior": "ipcidr",
    "url": "https://fastly.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/cncidr.txt",
    "path": "./ruleset/loyalsoldier/cncidr.yaml"
  },
  "lancidr": {
    ...ruleProviderCommon,
    "behavior": "ipcidr",
    "url": "https://fastly.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/lancidr.txt",
    "path": "./ruleset/loyalsoldier/lancidr.yaml"
  },
  "applications": {
    ...ruleProviderCommon,
    "behavior": "classical",
    "url": "https://fastly.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/applications.txt",
    "path": "./ruleset/loyalsoldier/applications.yaml"
  },
  "openai": {
    ...ruleProviderCommon,
    "behavior": "classical",
    "url": "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/refs/heads/meta/geo/geosite/classical/openai.yaml",
    "path": "./ruleset/MetaCubeX/openai.yaml"
  },
  "bybit": {
    ...ruleProviderCommon,
    "behavior": "classical",
    "url": "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/refs/heads/meta/geo/geosite/classical/bybit.yaml",
    "path": "./ruleset/MetaCubeX/bybit.yaml"
  },
  "pikpak": {
    ...ruleProviderCommon,
    "behavior": "classical",
    "url": "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/refs/heads/meta/geo/geosite/classical/pikpak.yaml",
    "path": "./ruleset/MetaCubeX/pikpak.yaml"
  },
  "anthropic": {
    ...ruleProviderCommon,
    "behavior": "classical",
    "url": "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/refs/heads/meta/geo/geosite/classical/anthropic.yaml",
    "path": "./ruleset/MetaCubeX/anthropic.yaml"
  },
  "google-gemini": {
    ...ruleProviderCommon,
    "behavior": "classical",
    "url": "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/refs/heads/meta/geo/geosite/classical/google-gemini.yaml",
    "path": "./ruleset/MetaCubeX/google-gemini.yaml"
  },
  "xai": {
    ...ruleProviderCommon,
    "behavior": "classical",
    "url": "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/refs/heads/meta/geo/geosite/classical/xai.yaml",
    "path": "./ruleset/MetaCubeX/xai.yaml"
  },
  "perplexity": {
    ...ruleProviderCommon,
    "behavior": "classical",
    "url": "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/refs/heads/meta/geo/geosite/classical/perplexity.yaml",
    "path": "./ruleset/MetaCubeX/perplexity.yaml"
  },
  "microsoft": {
    ...ruleProviderCommon,
    "behavior": "classical",
    "url": "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/refs/heads/meta/geo/geosite/classical/microsoft.yaml",
    "path": "./ruleset/MetaCubeX/microsoft.yaml"
  },
};
// 规则
const rules = [
  // 额外自定义规则       //在此添加你想要的规则
  "DOMAIN-SUFFIX,fsu.edu,🔗 全局直连",
  // 自定义规则
  "DOMAIN-SUFFIX,mdpi.com,🔗 全局直连",
  // ACS (American Chemical Society)
  // 涵盖 pubs.acs.org 等
  "DOMAIN-SUFFIX,acs.org,🔗 全局直连",
  // AIP (American Institute of Physics)
  // 涵盖 pubs.aip.org, publishing.aip.org 等
  "DOMAIN-SUFFIX,aip.org,🔗 全局直连",
  // APS (American Physical Society)
  // 涵盖 journals.aps.org 等
  "DOMAIN-SUFFIX,aps.org,🔗 全局直连",
  // Cambridge University Press (CUP)
  // 涵盖 cambridge.org/core 等
  "DOMAIN-SUFFIX,cambridge.org,🔗 全局直连",
  // Clarivate (Web of Science, EndNote等)
  "DOMAIN-KEYWORD,clarivate,🔗 全局直连", // 公司主域
  "DOMAIN-KEYWORD,webofscience,🔗 全局直连", // Web of Science 平台
  "DOMAIN-KEYWORD,webofknowledge,🔗 全局直连", // 旧域名/可能相关
  "DOMAIN-SUFFIX,webofscience.com,🔗 全局直连",
  "DOMAIN-SUFFIX,clarivate.com,🔗 全局直连",
  "DOMAIN-KEYWORD,endnote,🔗 全局直连", // EndNote (文献管理)
  "DOMAIN-SUFFIX,endnote.com,🔗 全局直连",
  // Elsevier (ScienceDirect, Scopus, Mendeley, ClinicalKey, etc.)
  "DOMAIN-KEYWORD,elsevier,🔗 全局直连", // 公司主域
  "DOMAIN-SUFFIX,elsevier.com,🔗 全局直连",
  "DOMAIN-KEYWORD,sciencedirect,🔗 全局直连", // ScienceDirect 平台
  "DOMAIN-SUFFIX,sciencedirect.com,🔗 全局直连",
  "DOMAIN-KEYWORD,scopus,🔗 全局直连", // Scopus 平台
  "DOMAIN-SUFFIX,scopus.com,🔗 全局直连",
  "DOMAIN-KEYWORD,mendeley,🔗 全局直连", // Mendeley 平台
  "DOMAIN-SUFFIX,mendeley.com,🔗 全局直连",
  "DOMAIN-KEYWORD,clinicalkey,🔗 全局直连", // ClinicalKey 平台
  "DOMAIN-SUFFIX,clinicalkey.com,🔗 全局直连",
  "DOMAIN-KEYWORD,reaxys,🔗 全局直连", // Reaxys 平台
  "DOMAIN-SUFFIX,reaxys.com,🔗 全局直连",
  "DOMAIN-KEYWORD,engineeringvillage,🔗 全局直连", // Engineering Village 平台
  "DOMAIN-SUFFIX,engineeringvillage.com,🔗 全局直连",
  "DOMAIN-KEYWORD,cell,🔗 全局直连", // Cell Press (Elsevier旗下)
  "DOMAIN-SUFFIX,cell.com,🔗 全局直连",
  "DOMAIN-KEYWORD,thelancet,🔗 全局直连", // The Lancet (Elsevier旗下)
  "DOMAIN-SUFFIX,thelancet.com,🔗 全局直连",
  "DOMAIN-KEYWORD,ssrn,🔗 全局直连", // SSRN (Elsevier旗下)
  "DOMAIN-SUFFIX,ssrn.com,🔗 全局直连",
  // IEEE (Institute of Electrical and Electronics Engineers)
  "DOMAIN-KEYWORD,ieee,🔗 全局直连", // 涵盖 ieeexplore.ieee.org 等
  "DOMAIN-SUFFIX,ieee.org,🔗 全局直连",
  "DOMAIN-KEYWORD,ieeexplore,🔗 全局直连",
  // JSTOR (Journal Storage)
  "DOMAIN-KEYWORD,jstor,🔗 全局直连",
  "DOMAIN-SUFFIX,jstor.org,🔗 全局直连",
  // Nature Portfolio (属于 Springer Nature)
  "DOMAIN-KEYWORD,nature,🔗 全局直连", // Nature 主站
  "DOMAIN-SUFFIX,nature.com,🔗 全局直连",
  // Oxford University Press (OUP)
  "DOMAIN-KEYWORD,oup,🔗 全局直连", // 涵盖 academic.oup.com 等
  "DOMAIN-SUFFIX,oup.com,🔗 全局直连",
  "DOMAIN-KEYWORD,oxfordacademic,🔗 全局直连", // academic.oup.com 的一部分
  // PubMed (由 NCBI/NLM/NIH 维护)
  "DOMAIN-KEYWORD,pubmed,🔗 全局直连",
  "DOMAIN-SUFFIX,ncbi.nlm.nih.gov,🔗 全局直连", // NCBI 主站 (包含 PubMed)
  "DOMAIN-SUFFIX,nih.gov,🔗 全局直连", // NIH 主站 (上级机构)
  // RSC (Royal Society of Chemistry)
  "DOMAIN-KEYWORD,rsc,🔗 全局直连", // 涵盖 pubs.rsc.org 等
  "DOMAIN-SUFFIX,rsc.org,🔗 全局直连",
  // SAGE Publishing
  "DOMAIN-KEYWORD,sagepub,🔗 全局直连", // 涵盖 journals.sagepub.com 等
  "DOMAIN-SUFFIX,sagepub.com,🔗 全局直连",
  // Springer Nature (Springer, Nature, BMC)
  "DOMAIN-KEYWORD,springer,🔗 全局直连", // 涵盖 link.springer.com 等
  "DOMAIN-SUFFIX,springer.com,🔗 全局直连",
  "DOMAIN-KEYWORD,springerlink,🔗 全局直连", // 旧域名/别名
  "DOMAIN-KEYWORD,springernature,🔗 全局直连", // 公司主域
  "DOMAIN-SUFFIX,springernature.com,🔗 全局直连",
  "DOMAIN-KEYWORD,biomedcentral,🔗 全局直连", // BMC (BioMed Central, Springer Nature旗下)
  "DOMAIN-SUFFIX,biomedcentral.com,🔗 全局直连",
  // Taylor & Francis (T&F)
  "DOMAIN-KEYWORD,tandfonline,🔗 全局直连", // T&F 平台
  "DOMAIN-SUFFIX,tandfonline.com,🔗 全局直连",
  "DOMAIN-KEYWORD,taylorfrancis,🔗 全局直连", // 公司主域
  "DOMAIN-SUFFIX,taylorfrancis.com,🔗 全局直连",
  "DOMAIN-KEYWORD,taylorandfrancis,🔗 全局直连", // 公司别名
  "DOMAIN-SUFFIX,taylorandfrancis.com,🔗 全局直连",
  // Wiley
  "DOMAIN-KEYWORD,wiley,🔗 全局直连", // 涵盖 onlinelibrary.wiley.com 等
  "DOMAIN-SUFFIX,wiley.com,🔗 全局直连",
  "DOMAIN-KEYWORD,onlinelibrary,🔗 全局直连", // Wiley Online Library 的一部分
  "DOMAIN-SUFFIX,onlinelibrary.wiley.com,🔗 全局直连", // 精确匹配平台域名
  // researchgate
  "DOMAIN-KEYWORD,researchgate,🔗 全局直连",
  // == 支持性服务 & CDN ==
  "DOMAIN-KEYWORD,disqus,🔗 全局直连", // 评论系统 (如 acm-prod.disqus.com)
  "DOMAIN-SUFFIX,disqus.com,🔗 全局直连",
  "DOMAIN-KEYWORD,readspeaker,🔗 全局直连", // 文本转语音服务
  "DOMAIN-SUFFIX,readspeaker.com,🔗 全局直连",
  "DOMAIN-KEYWORD,mathjax,🔗 全局直连", // 数学公式渲染
  "DOMAIN-SUFFIX,mathjax.org,🔗 全局直连",
  "DOMAIN-KEYWORD,cloudfront,🔗 全局直连", // Amazon CDN
  "DOMAIN-SUFFIX,cloudfront.net,🔗 全局直连",
  "DOMAIN-KEYWORD,els-cdn,🔗 全局直连", // Elsevier CDN
  "DOMAIN-SUFFIX,els-cdn.com,🔗 全局直连",
  "DOMAIN-KEYWORD,sciencedirectassets,🔗 全局直连", // ScienceDirect 静态资源
  "DOMAIN-SUFFIX,sciencedirectassets.com,🔗 全局直连",
  "DOMAIN-KEYWORD,bootstrapcdn,🔗 全局直连", // Bootstrap CDN
  "DOMAIN-SUFFIX,bootstrapcdn.com,🔗 全局直连",
  "DOMAIN-KEYWORD,jquery,🔗 全局直连", // jQuery CDN (虽然常自托管)
  "DOMAIN-SUFFIX,jquery.com,🔗 全局直连",
  "DOMAIN-KEYWORD,cloudflare,🔗 全局直连", // Cloudflare CDN & 安全服务
  "DOMAIN-SUFFIX,cloudflare.com,🔗 全局直连",
  "DOMAIN-KEYWORD,akamai,🔗 全局直连", // Akamai CDN
  "DOMAIN-SUFFIX,akamaized.net,🔗 全局直连",
  "DOMAIN-SUFFIX,akamaihd.net,🔗 全局直连",
  "DOMAIN-KEYWORD,highwire,🔗 全局直连", // HighWire Press (某些期刊平台)
  "DOMAIN-SUFFIX,highwire.org,🔗 全局直连",
  "DOMAIN-SUFFIX,highwirepress.com,🔗 全局直连",
  "DOMAIN-KEYWORD,silverchair,🔗 全局直连", // Silverchair (某些期刊平台)
  "DOMAIN-SUFFIX,silverchair.com,🔗 全局直连",
  "DOMAIN-KEYWORD,shibboleth,🔗 全局直连", // Shibboleth 认证相关
  "DOMAIN-KEYWORD,orcid,🔗 全局直连", // ORCID 认证
  "DOMAIN-SUFFIX,orcid.org,🔗 全局直连",
  // AMS
  "DOMAIN-KEYWORD,ametsoc,🔗 全局直连",
  // ZOTERO
  "DOMAIN-KEYWORD,zotero,🔗 全局直连",

  "PROCESS-NAME,steam.exe,🐬 自定义直连",
  "DOMAIN-SUFFIX,immersivetranslate.com,🐳 自定义代理",
  // "DOMAIN-SUFFIX,bing.com,🐳 自定义代理",
  // 自定义规则
  "DOMAIN-SUFFIX,googleapis.cn,🔰 模式选择", // Google服务
  "DOMAIN-SUFFIX,gstatic.com,🔰 模式选择", // Google静态资源
  "DOMAIN-SUFFIX,xn--ngstr-lra8j.com,🔰 模式选择", // Google Play下载服务
  "DOMAIN-SUFFIX,github.io,🔰 模式选择", // Github Pages
  "DOMAIN,v2rayse.com,🔰 模式选择", // V2rayse节点工具
  // blackmatrix7 规则集

  // MetaCubeX 规则集
  "RULE-SET,openai,💸 ChatGPT-Gemini-XAI-Perplexity",
  "RULE-SET,pikpak,🅿️ PikPak",
  "RULE-SET,bybit,🪙 Bybit",
  "RULE-SET,anthropic,💵 Claude",
  "RULE-SET,google-gemini,💸 ChatGPT-Gemini-XAI-Perplexity",
  "RULE-SET,xai,💸 ChatGPT-Gemini-XAI-Perplexity",
  "RULE-SET,perplexity,💸 ChatGPT-Gemini-XAI-Perplexity",
  // Loyalsoldier 规则集
  "RULE-SET,applications,🔗 全局直连",
  "RULE-SET,private,🔗 全局直连",
  "RULE-SET,reject,🥰 广告过滤",
  "RULE-SET,microsoft,Ⓜ️ 微软服务",
  "RULE-SET,icloud,🍎 苹果服务",
  "RULE-SET,apple,🍎 苹果服务",
  "RULE-SET,google,📢 谷歌服务",
  "RULE-SET,proxy,🔰 模式选择",
  "RULE-SET,gfw,🔰 模式选择",
  "RULE-SET,tld-not-cn,🔰 模式选择",
  "RULE-SET,direct,🔗 全局直连",
  "RULE-SET,lancidr,🔗 全局直连,no-resolve",
  "RULE-SET,cncidr,🔗 全局直连,no-resolve",
  "RULE-SET,telegramcidr,📲 电报消息,no-resolve",
  // 其他规则
  "GEOIP,LAN,🔗 全局直连,no-resolve",
  "GEOIP,CN,🔗 全局直连,no-resolve",
  "MATCH,🐟 漏网之鱼"
];
// 代理组通用配置
const groupBaseOption = {
  "interval": 0,
  "timeout": 3000,
  "url": "https://www.google.com/generate_204",
  "lazy": true,
  "max-failed-times": 3,
  "hidden": false
};

const landingNodeProxies = [
  {
    "name": "webshare", // 给你的落地节点起个名字
    "server": "", // 替换成你的落地节点 IP 或域名
    "port": 12345, // 替换成你的落地节点端口
    "type": "socks5",
    "username": "", // 替换成你的用户名
    "password": "", // 替换成你的密码
    "tls": false,
    "skip-cert-verify": true,
    "udp": true,
    "dialer-proxy": "⚙️ 节点选择"
  },
  // 如果有更多落地节点，在这里继续添加
  // {
  //   "name": "landing-node-2",
  //   ...
  //   "dialer-proxy": "⚙️ 节点选择"
  // }
];

const landingNodeNames = landingNodeProxies.map(p => p.name);

const proxyGroupsConfig = [
  {
    ...groupBaseOption,
    "name": "🔰 模式选择",
    "type": "select",
    "proxies": [
      "⚙️ 节点选择",
      "🕊️ 落地节点",
      "🔗 全局直连"
    ]
  },
  {
    ...groupBaseOption,
    "name": "⚙️ 节点选择",
    "type": "select",
    "proxies": ["♻️ 延迟选优", "🚑 故障转移", "⚖️ 负载均衡(散列)", "☁️ 负载均衡(轮询)"],
    "include-all": true,
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/adjust.svg"
  },
  {
    ...groupBaseOption,
    "name": "🕊️ 落地节点",
    "type": "select",
    "proxies": [...landingNodeNames],
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/openwrt.svg"
  },
  {
    ...groupBaseOption,
    "name": "♻️ 延迟选优",
    "type": "url-test",
    "tolerance": 50,
    "include-all": true,
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/speed.svg"
  },
  {
    ...groupBaseOption,
    "name": "🚑 故障转移",
    "type": "fallback",
    "include-all": true,
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/ambulance.svg"
  },
  {
    ...groupBaseOption,
    "name": "⚖️ 负载均衡(散列)",
    "type": "load-balance",
    "strategy": "consistent-hashing",
    "include-all": true,
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/merry_go.svg"
  },
  {
    ...groupBaseOption,
    "name": "☁️ 负载均衡(轮询)",
    "type": "load-balance",
    "strategy": "round-robin",
    "include-all": true,
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/balance.svg"
  },
  {
    ...groupBaseOption,
    "name": "🌍 国外媒体",
    "type": "select",
    "proxies": ["🔰 模式选择", "⚙️ 节点选择", "🕊️ 落地节点", "♻️ 延迟选优", "🚑 故障转移", "⚖️ 负载均衡(散列)", "☁️ 负载均衡(轮询)", "🔗 全局直连"],
    "include-all": true,
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/youtube.svg"
  },
  {
    ...groupBaseOption,
    "name": "💸 ChatGPT-Gemini-XAI-Perplexity",
    "type": "url-test",
    "proxies": ["🔰 模式选择", "⚙️ 节点选择", "🕊️ 落地节点", "🔗 全局直连", "♻️ 延迟选优", "🚑 故障转移", "⚖️ 负载均衡(散列)", "☁️ 负载均衡(轮询)"],
    "include-all": true,
    "filter": "(?i)美|us|usa|unitedstates|america|洛杉矶|圣何塞|硅谷|西雅图|纽约|芝加哥",
    "exclude-filter": "(?i)港|hk|hongkong|hong kong|俄|ru|russia|澳|macao",
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/chatgpt.svg"
  },
  {
    ...groupBaseOption,
    "name": "💵 Claude",
    "type": "select",
    "proxies": ["🔰 模式选择", "⚙️ 节点选择", "🕊️ 落地节点", "🔗 全局直连", "♻️ 延迟选优", "🚑 故障转移", "⚖️ 负载均衡(散列)", "☁️ 负载均衡(轮询)"],
    "include-all": true,
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/claude.svg"
  },
  {
    ...groupBaseOption,
    "name": "🪙 Bybit",
    "type": "select",
    "proxies": ["🔰 模式选择", "⚙️ 节点选择", "🕊️ 落地节点", "🔗 全局直连", "♻️ 延迟选优", "🚑 故障转移", "⚖️ 负载均衡(散列)", "☁️ 负载均衡(轮询)"],
    "include-all": true,
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/link.svg"
  },
  {
    ...groupBaseOption,
    "name": "🅿️ PikPak",
    "type": "select",
    "proxies": ["🔰 模式选择", "⚙️ 节点选择", "🕊️ 落地节点", "🔗 全局直连", "♻️ 延迟选优", "🚑 故障转移", "⚖️ 负载均衡(散列)", "☁️ 负载均衡(轮询)"],
    "include-all": true,
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/link.svg"
  },
  {
    ...groupBaseOption,
    "name": "📲 电报消息",
    "type": "select",
    "proxies": ["🔰 模式选择", "⚙️ 节点选择", "🕊️ 落地节点", "♻️ 延迟选优", "🚑 故障转移", "⚖️ 负载均衡(散列)", "☁️ 负载均衡(轮询)", "🔗 全局直连"],
    "include-all": true,
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/telegram.svg"
  },
  {
    ...groupBaseOption,
    "name": "📢 谷歌服务",
    "type": "select",
    "proxies": ["🔰 模式选择", "⚙️ 节点选择", "🕊️ 落地节点", "♻️ 延迟选优", "🚑 故障转移", "⚖️ 负载均衡(散列)", "☁️ 负载均衡(轮询)", "🔗 全局直连"],
    "include-all": true,
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/google.svg"
  },
  {
    ...groupBaseOption,
    "name": "🍎 苹果服务",
    "type": "select",
    "proxies": ["🔰 模式选择", "⚙️ 节点选择", "🕊️ 落地节点", "♻️ 延迟选优", "🚑 故障转移", "⚖️ 负载均衡(散列)", "☁️ 负载均衡(轮询)", "🔗 全局直连"],
    "include-all": true,
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/apple.svg"
  },
  {
    ...groupBaseOption,
    "name": "Ⓜ️ 微软服务",
    "type": "select",
    "proxies": ["♻️ 延迟选优", "🔗 全局直连", "🔰 模式选择", "⚙️ 节点选择", "🕊️ 落地节点", "🚑 故障转移", "⚖️ 负载均衡(散列)", "☁️ 负载均衡(轮询)"],
    "include-all": true,
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/microsoft.svg"
  },
  {
    ...groupBaseOption,
    "name": "🥰 广告过滤",
    "type": "select",
    "proxies": ["REJECT", "DIRECT"],
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/bug.svg"
  },
  {
    ...groupBaseOption,
    "name": "🔗 全局直连",
    "type": "select",
    "proxies": ["DIRECT", "⚙️ 节点选择", "♻️ 延迟选优", "🚑 故障转移", "⚖️ 负载均衡(散列)", "☁️ 负载均衡(轮询)"],
    "include-all": true,
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/link.svg"
  },
  {
    ...groupBaseOption,
    "name": "❌ 全局拦截",
    "type": "select",
    "proxies": ["REJECT", "DIRECT"],
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/block.svg"
  },
  {
    ...groupBaseOption,
    "name": "🐬 自定义直连",
    "type": "select",
    "include-all": true,
    "proxies": ["🔗 全局直连", "🔰 模式选择", "⚙️ 节点选择", "♻️ 延迟选优", "🚑 故障转移", "⚖️ 负载均衡(散列)", "☁️ 负载均衡(轮询)"],
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/unknown.svg"
  },
  {
    ...groupBaseOption,
    "name": "🐳 自定义代理",
    "type": "select",
    "include-all": true,
    "proxies": ["🔰 模式选择", "⚙️ 节点选择", "🕊️ 落地节点", "♻️ 延迟选优", "🚑 故障转移", "⚖️ 负载均衡(散列)", "☁️ 负载均衡(轮询)", "🔗 全局直连"],
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/openwrt.svg"
  },
  {
    ...groupBaseOption,
    "name": "🐟 漏网之鱼",
    "type": "select",
    "proxies": ["🔰 模式选择", "⚙️ 节点选择", "🕊️ 落地节点", "♻️ 延迟选优", "🚑 故障转移", "⚖️ 负载均衡(散列)", "☁️ 负载均衡(轮询)", "🔗 全局直连"],
    "include-all": true,
    "icon": "https://fastly.jsdelivr.net/gh/clash-verge-rev/clash-verge-rev.github.io@main/docs/assets/icons/fish.svg"
  }
];

// 多订阅合并，这里添加额外的地址
const proxyProviders = {
  "p1": {
    "type": "http",   // 订阅链接
    "url": "https://google.com",
    "interval": 86400,  // 自动更新时间 86400 (秒) / 3600 = 24 小时
    "proxy": "🔰 模式选择",
    "override": {
      "additional-prefix": "p1 |"  // 节点名称前缀 p1，用于区别机场节点
    }
  },
  // 其他订阅地址
}

// 程序入口
function main(config) {
  const originalProxies = config?.proxies ? [...config.proxies] : [];
  const proxyCount = originalProxies.length;
  const originalProviders = config?.["proxy-providers"] || {};
  const proxyProviderCount = originalProviders !== null && typeof originalProviders === 'object' ? Object.keys(originalProviders).length : 0;

  if (proxyCount === 0 && proxyProviderCount === 0) {
    throw new Error("配置文件中未找到任何代理");
  }

  config["dns"] = dnsConfig;
  config["rule-providers"] = ruleProviders;
  config["rules"] = rules; // Use the modified rules array defined above

  // Process original proxies (just ensure UDP)
  const processedProxies = originalProxies.map(proxy => {
    if (proxy && typeof proxy === 'object' && proxy.name) {
      proxy.udp = true;

      // 节点绑定的接口，从此接口发起连接，适用于部分vpn情况
      // proxy["interface-name"] = "WLAN"
      // proxy["interface-name"] = "以太网"
    } else {
      console.warn("警告：发现一个无效或缺少名称的原始代理配置:", proxy);
      return null;
    }
    return proxy;
  }).filter(p => p !== null);

  // Combine proxies
  config["proxies"] = [...processedProxies, ...landingNodeProxies];
  config["proxy-providers"] = {
    ...originalProviders,
    ...proxyProviders
  };

  // 转义正则元字符，保证名字按“字面量”匹配
  function escapeForRegExp(s) {
    return s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  }

  // 取出所有落地节点的名字，并做转义
  const landingNodeNames = landingNodeProxies.map(p => p.name);
  const escapedNames = landingNodeNames
    .map(escapeForRegExp)
    .join('|');

  // 构造只匹配完全等于这些名字的正则
  const excludeLandingFilter = escapedNames
    ? `^(?:${escapedNames})$`
    : null;

  // 定义需要排除落地节点的组名
  const groupsToExcludeLandingNodes = [
    "⚙️ 节点选择",
    "♻️ 延迟选优",
    "⚖️ 负载均衡(散列)",
    "☁️ 负载均衡(轮询)"
  ];

  // 遍历所有代理组配置，为指定的组添加排除落地节点的过滤器
  const finalProxyGroups = proxyGroupsConfig.map(group => {
    // 检查当前组名是否在需要排除落地节点的列表中，并且确实有落地节点需要排除
    if (groupsToExcludeLandingNodes.includes(group.name) && excludeLandingFilter) {
      // 合并已有的 exclude-filter：只要旧规则 或 新排除规则 匹配，就排除
      // 如果 group["exclude-filter"] 已存在，则用 | 连接新旧规则
      // 否则直接使用新的 excludeLandingFilter
      const existingFilter = group["exclude-filter"];
      group["exclude-filter"] = existingFilter
        ? `(${existingFilter})|(${excludeLandingFilter})`
        : excludeLandingFilter;

      console.log(
        `信息：为组 [${group.name}] 添加或合并了落地节点排除过滤器: ${group["exclude-filter"]}`
      );
    }
    return group; // 返回（可能已修改的）组配置
  });

  config["proxy-groups"] = finalProxyGroups; // 使用处理过的代理组
  return config;
}

// 参考配置：https://github.com/clash-verge-rev/clash-verge-rev/discussions/2606
// 参考配置：https://github.com/kshsong/Clash_academic_rules/blob/main/script.js
// 参考配置：https://github.com/xiaolin-007/clash-verge-script
// 根据自己的需求自定义！！！