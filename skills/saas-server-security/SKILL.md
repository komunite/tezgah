---
name: saas-server-security
description: >
  SaaS sunucularını güvenlik denetimine al ve production-ready hale getir.
  413 güvenlik kontrolü, 29 kategori (SSH, Firewall, Docker, TLS, HTTP Headers),
  CIS/PCI-DSS/HIPAA uyumluluk haritalama, 19 adımlı sertleştirme.
  Tetikleyiciler: "sunucu güvenliği", "server audit", "güvenlik taraması",
  "sunucu sertleştirme", "audit skoru".
---

# SaaS Sunucu Güvenliği

SaaS uygulamanı barındıran sunucuları güvenlik denetimine al ve sertleştir. Kastell MCP araçlarıyla tam yaşam döngüsü: denetim → analiz → sertleştirme → doğrulama.

## Bağımlılık

```bash
claude plugins add kastell
```

En az bir kayıtlı sunucu gerekli (`kastell add` veya `server_manage` MCP aracı).

## İş Akışı

### Faz 1: Güvenlik Denetimi

413 kontrol, 29 kategori ile kapsamlı tarama:

```text
server_audit aracını kullan: server: "<isim>", format: "summary"
```

Uyumluluk filtreli sonuçlar için:

```text
server_audit aracını kullan: framework: "pci-dss"
```

### Faz 2: 5 Güvenlik Alanına Göre Analiz

| Alan | Kategoriler | Odak |
|------|-----------|------|
| Çevre | Ağ, Güvenlik Duvarı, DNS | Dış saldırı yüzeyi |
| Kimlik Doğrulama | SSH, Auth, Kripto, Hesaplar | Kimlik kontrolleri |
| Çalışma Zamanı | Docker, Servisler, Boot, Zamanlama | Servis maruziyeti |
| İç Yapı | Dosya Sistemi, Loglama, Kernel, Bellek | Sistem sertleştirme |
| Uyumluluk | Güncellemeler, TLS, HTTP Headers, Secrets vb. | Hijyen |

### Faz 3: Sertleştirme

19 adımlı production sertleştirme (SSH, fail2ban, UFW, sysctl, auditd, AIDE, Docker):

```text
server_lock aracını kullan: server: "<isim>", dryRun: true
```

Dry-run çıktısını incele, sonra `production: true` ile uygula.

### Faz 4: Doğrulama

Skor iyileşmesini doğrulamak için tekrar denetle:

```text
server_audit aracını kullan: server: "<isim>", format: "score"
```

## Hızlı Kazanımlar

Denetim sonrası önceliklendirme:

1. **Kritik** (3x ağırlık): Exploit edilebilir — hemen düzelt
2. **Uyarı** (2x ağırlık): Risk var — sonraki bakım penceresinde düzelt
3. **Bilgi** (1x ağırlık): En iyi pratik — uygun zamanda ele al

`server_audit` aracını `explain: true` ile kullanarak kontrol bazında düzeltme rehberi al.

## Bağlı Skill'ler

- `saas-deployment` — Deployment sonrası güvenlik kontrolü
- `saas-api-security` — API katmanı güvenliği (bu skill sunucu katmanını kapsar)

## Araçlar

[Kastell](https://kastell.dev) — 13 MCP aracı ile sunucu güvenliği yönetimi.
