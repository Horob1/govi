# 01 - Foundation

> Core glassmorphism. Read this before any UI.

## Glass formula

```
backdrop-filter: blur(X) + bg rgba opacity 10-30%
blur: 5-20px, standard 8-16px on mobile
opacity: 10-30% depending on backdrop
start low (4-6px) -> increase only if needed
```

## Rules

- blur >20px = heavy, lag on low-end -> avoid
- low opacity (15%) when backdrop is busy + high blur (~20px)
- high opacity (25%) when backdrop is simple + low blur (~8px)
- always add 10-30% tint under text for readability

## Depth

- needs busy backdrop: vivid gradient / flat illustration
- suggested gradients: blue->yellow, purple->pink, blue->teal
- glass floats above backdrop, never sinks
- design BACKDROP first, glass second - never reverse

## Less is more

- max 2-3 glass panels / screen
- only for high priority: nav, primary card, modal, FAB
- secondary = solid bg, no glass
- fallback: solid bg when blur unsupported / user disabled motion

## A11y + Perf

- WCAG: normal text >=4.5:1, large text >=3:1
- check contrast against worst-case backdrop
- limit blur layers, never animate blur directly
- test on low-end, check FPS / GPU
- respect prefers-reduced-motion -> drop blur if requested
- 1px border at 20-30% opacity to separate glass from similar bg

## Fixed params

| param | value | note |
|-------|-------|------|
| blur mobile | 8-16px | start 4-6px |
| blur modal | ~12px | radius 16px |
| opacity | 10-30% | tint under text |
| border | 1px | 20-30% opacity |
| outer shadow | 1-2dp | subtle or none |
| inner shadow | very subtle | only FAB / thick card |