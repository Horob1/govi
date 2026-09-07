# 05 - Patterns

> When to use, when not. Violate = clutter + slow + unreadable.

## Use glass when

- primary action (FAB, CTA)
- featured info (balance, main chart)
- nav / drawer / modal / toast
- needs depth over gradient

## Do not use when

- long list, dense table, many-field form
- backdrop already busy / high contrast
- >3 glass panels / screen
- long-form reading text

## Environment design

- design BACKDROP first, glass second
- backdrop must be color-stable, no light-dark interleaving under text
- add subtle gradient / pattern behind glass for uniformity
- WCAG check against worst-case backdrop, not just pretty case

## Contrast fix ladder

```
1. increase blur (8->16px)
2. increase opacity (15->30%)
3. add 10-30% tint under text
4. switch to solid bg (drop glass)
5. add 1px soft text-shadow
```
- try in order, do not jump to 4

## Rollout

- start with 1-2 spots, measure FPS / GPU, then expand
- test light + dark + low-end + reduced-motion
- fallback: solid bg when blur off - still clean, still readable

## Review checklist (PR gate)

- [ ] only 2-3 glass / screen?
- [ ] blur 8-16, opacity 10-30?
- [ ] WCAG 4.5:1 / 3:1 pass?
- [ ] no blur animation?
- [ ] backdrop designed stable?
- [ ] solid fallback exists?
- [ ] tested both light + dark?
- [ ] motion 200-300ms ease-out?

## Real examples (reference)

- AnyDistance: Start pill light blur + Collectibles heavier blur for readability over nature photo
- Arc / Fixx: pure dark + frosted glass, semi-transparent modal
- stacked: top card brightest / sharpest, like real embossed glass

## Anti-patterns

- full-screen blur
- glass on glass (stacked blur)
- thin text on transparent glass
- neon glare gradient behind dark glass