# 03 - Components

> Per-component glass spec. Copy params, do not invent.

## Nav Bar (top / bottom)

- bg: glass-bg + blur 8-12px + border-bottom 1px glass-border
- fixed, content slides behind -> depth visible
- text: text-primary bold, icon 24px
- fallback: solid bg 90% when blur unsupported

## Glass Card (balance, chart, report)

- bg: glass-bg + blur 8-12px
- border: 1px glass-border, radius 12-16px
- shadow: glass-shadow 1-2dp
- text: bold, high contrast (dark on light glass / light on dark glass)
- hierarchy: most important card brightest / sharpest, secondary dimmer
- pricing / dashboard: only featured tier uses glass, rest solid

## Modal / Bottom Sheet

- overlay: rgba(0,0,0,0.3) + 4px blur behind overlay
- panel: glass-bg-strong + blur 12px + radius 16px
- slide-up 250ms ease-out, do not animate blur
- top radius 16px (bottom sheet), full 16px (center modal)

## Input / Form

- bg: glass-bg (subtle, blur 4-6px) + border 1px glass-border
- very subtle inner shadow if thickness needed
- focus: accent border + soft glow
- placeholder: text-secondary 60%
- never plain opaque white

## FAB / Primary Button

- shape: pill or circle, radius-pill
- bg: rgba(255,255,255,0.85) light / rgba(50,50,70,0.85) dark + blur 8px
- border: 1px glass-border + subtle inner shadow
- shadow: glass-shadow + rim light toward light source (top / left)
- icon / text: accent or white, must meet 4.5:1

## Sidebar / Drawer

- bg: glass-bg + blur 12-16px + border-right 1px glass-border
- backdrop behind: 4px blur
- menu item: text-primary, active = accent bg 10% + accent left border

## Toast / Alert

- bg: glass-bg-strong (highest opacity) + blur 12px
- radius 12px, border 1px glass-border
- position: bottom center, slide-up + fade
- auto-dismiss 2-3s, do not cover FAB
- text: always 4.5:1, if backdrop busy -> bump opacity to 40%

## Quick params

| comp | blur | opacity | radius | border |
|------|------|---------|--------|--------|
| nav | 8-12 | 15-25% | 0 / pill | 1px bottom |
| card | 8-12 | 15-25% | 12-16 | 1px |
| modal | 12 | 25-35% | 16 | 1px |
| input | 4-6 | 10-15% | 8-12 | 1px |
| FAB | 8 | 80-85% | pill | 1px + inner |
| toast | 12 | 30-40% | 12 | 1px |

## ArkTS note

- use `backdropFilter` / `backgroundBlurStyle` (HarmonyOS) + solid fallback
- soft corners, avoid sharp edges on glass
- every text via `t()` - no hardcode (AGENTS.md i18n rule)