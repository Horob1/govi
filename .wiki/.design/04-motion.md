# 04 - Motion

> Subtle, smooth, no lag. Wrong = jank on low-end.

## Timing

| type | duration | easing | usage |
|------|----------|--------|-------|
| entrance | 200-300ms | ease-out / spring | modal, sheet, toast in |
| exit | 200-300ms | ease-in | modal, toast out (fade + slide) |
| micro | 100-150ms | ease-out | button press, chip |
| large move | 250ms | ease-out | drawer, page transition |

- never <100ms (invisible), never >400ms (sluggish)
- NNG: 100-500ms, real sweet spot 200-300ms

## Forbidden

- NEVER animate `backdrop-filter` / `blur` directly -> heavy lag
- workaround: animate opacity / background-color / transform
- do not animate multiple glass layers at once
- use `will-change` sparingly, never over-apply

## Patterns

```
enter: slide-up + fade-in  (bottom sheet from bottom)
exit:  slide-down + fade-out (reverse, same speed)
toast: slide-up 200ms + fade, dismiss slide-down 200ms
modal: scale 0.95->1 + fade 250ms (optional)
```

## Reduced motion

- respect system `prefers-reduced-motion` / HarmonyOS reduce motion
- when enabled: drop blur, cut duration to 100ms or 0, fade only
- provide toggle in settings if possible

## Haptics (mobile)

- light haptic on: open sheet, tap FAB, confirm action
- use HarmonyOS vibrator API, short 20-30ms
- not every tap -> only meaningful actions

## Check

- [ ] no transition on blur?
- [ ] every enter / exit 200-300ms?
- [ ] tested on low-end, no jank?
- [ ] reduced-motion fallback exists?