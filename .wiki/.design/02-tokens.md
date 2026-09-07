# 02 - Tokens (Light / Dark)

> Single source. Every color / blur / border from here, no stray hex.

## Light Theme (default)

| token | value | usage |
|-------|-------|-------|
| `bg-page` | gradient #E8F0FE -> #F0E6FF or #E0F7FA -> #FFF9C4 | backdrop behind glass |
| `glass-bg` | rgba(255,255,255,0.15) ~ 15-25% | card / nav / modal |
| `glass-bg-strong` | rgba(255,255,255,0.25) | toast / alert - higher readability |
| `glass-border` | rgba(255,255,255,0.25) 1px | light rim |
| `glass-shadow` | 0 4px 16px rgba(0,0,0,0.08) | outer shadow |
| `glass-inner` | inset 0 1px 0 rgba(255,255,255,0.4) | FAB / thick card |
| `text-primary` | #1A1A2E | text on light glass |
| `text-secondary` | #4A4A6A 70% | secondary text |
| `text-on-glass` | #1A1A2E | ensure 4.5:1 on glass-bg |
| `accent` | #4F46E5 (indigo) | CTA, link |
| `success` | #059669 | income + |
| `danger` | #DC2626 | expense - |
| `blur-sm` | 4-6px | input / light nav |
| `blur-md` | 8-12px | card / modal standard |
| `blur-lg` | 16-20px | busy backdrop |
| `radius-sm` | 8px | input |
| `radius-md` | 12-16px | card / modal |
| `radius-pill` | 999px | FAB / chip / pill nav |

## Dark Theme

| token | value | usage |
|-------|-------|-------|
| `bg-page` | gradient #0F172A -> #1E1B4B or #0F172A -> #312E81 | deep dark backdrop |
| `glass-bg` | rgba(30,30,45,0.35) ~ 30-40% | card / nav / modal |
| `glass-bg-strong` | rgba(30,30,45,0.55) | toast / alert |
| `glass-border` | rgba(255,255,255,0.10) 1px or rgba(100,120,255,0.15) | avoid harsh white |
| `glass-shadow` | 0 8px 32px rgba(0,0,0,0.35) | darker outer |
| `glass-inner` | inset 0 1px 0 rgba(255,255,255,0.08) | FAB |
| `text-primary` | #F1F5F9 | text on dark glass |
| `text-secondary` | #94A3B8 | secondary |
| `text-on-glass` | #F1F5F9 | 4.5:1 on glass-bg dark |
| `accent` | #818CF8 (indigo-300) | CTA dark |
| `success` | #34D399 | income dark |
| `danger` | #F87171 | expense dark |
| `blur-*` | same as light | keep |
| `radius-*` | same as light | keep |

## Opacity rule (both themes)

```
simple backdrop -> blur 8px   + opacity 25%
busy backdrop   -> blur 16-20px + opacity 15%
high readability -> increase opacity, not infinite blur
```

## ArkTS mapping

```ets
// entry/src/main/ets/shared/ui/tokens.ets (suggested)
export const GlassTokens = {
  blurSm: 6, blurMd: 12, blurLg: 16,
  radiusSm: 8, radiusMd: 16, radiusPill: 999
}
// colors -> AppScope/resources/{base,en_US,zh_CN}/element/color.json
// blur -> backdropFilter in .ets, fallback: solid bg when unsupported
```

## Check

- [ ] every color via token, no stray hex?
- [ ] light + dark both >=4.5:1?
- [ ] dark border not pure white (avoid glare)?