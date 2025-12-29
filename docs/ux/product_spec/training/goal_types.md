# Goal Setting & Planning

Ash supports four distinct goal types, each with a tailored training experience and periodization strategy.

## 1. Distance Milestone Goals
*Examples: "Run my first 10K", "Complete a half marathon", "Run 5 miles without stopping"*

**Philosophy:** Completion over speed. Build endurance safely and prevent injury.

### What to Expect
| Aspect | Detail |
|--------|--------|
| **Training Style** | **Time-based**: "Run for 30 minutes" (reduces pressure for beginners) |
| **Intensity** | **Pyramidal**: 75-80% Easy, 15-20% Moderate, 0-5% High |
| **Pillar Focus** | **Running (High)**, Strength (Med), Mobility (Med) |
| **Flexibility** | **High**: Skip workouts without guilt. Consistency > Perfection. |

### Mesocycle Structure
*   **Base Phase:** 6-8 weeks of pure aerobic building
*   **Distance Familiarization:** Practice runs at 80-90% of goal distance
*   **Minimal Taper:** 7-10 days, 20-30% volume reduction
*   **Recovery Weeks:** Every 3-4 weeks, reduce volume by 30%

### Success Metrics
*   Completing weekly long run
*   Increasing total weekly running time
*   Injury-free progression

---

## 2. Time Performance Goals
*Examples: "Sub-30 minute 5K", "Break 2 hours in the half marathon"*

**Philosophy:** Improve speed and efficiency. Track quantifiable progress.

### What to Expect
| Aspect | Detail |
|--------|--------|
| **Training Style** | **Distance-based**: "6 × 400m intervals" (specific targets) |
| **Intensity** | **Polarized (80/20)**: 80% Easy, 20% Hard (Zone 4/5). Minimal "moderate" junk miles. |
| **Pillar Focus** | **Running (High)**, Strength (Med-High), Mobility (Med) |
| **Flexibility** | **Medium**: Key workouts (Intervals/Tempo) are critical. |

### Mesocycle Structure
*   **Base (4-6 wks):** Build aerobic foundation
*   **Build (4-6 wks):** Introduce race-specific intensity
*   **Peak (2-3 wks):** Highest volume + intensity
*   **Taper (1-2 wks):** Reduce volume 40-50%, maintain intensity

### Success Metrics
*   Pace improvements in monthly time trials
*   Ability to sustain goal pace for longer durations

---

## 3. Event Goals (Race-Specific)
*Examples: "Austin Marathon on Feb 16", "NYC Half Marathon"*

**Philosophy:** Peak performance on a specific date. All training builds toward race day.

### What to Expect
| Aspect | Detail |
|--------|--------|
| **Training Style** | **Phased**: Base → Build → Peak → Taper |
| **Intensity** | Varies by phase. Peak phase has highest intensity. |
| **Pillar Focus** | **Running (High)**. Strength reduces in taper. Mobility increases in taper. |
| **Flexibility** | **Low** during peak weeks. Missed workouts are not made up. |

### Taper Protocols
| Race Dist | Length | Protocol |
|-----------|--------|----------|
| **5K** | 7-10 days | -30% W1, -50% final days |
| **10K** | 10-14 days | -30% W1, -50% W2 |
| **Half** | 2 weeks | -30% W1, -50% W2 |
| **Marathon** | 3 weeks | -20% W1, -40% W2, -60% W3 |

---

## 4. Maintenance Goals
*Examples: "Keep running 3x/week during busy season"*

**Philosophy:** Sustain fitness with minimal effective dose. Reduce pressure, increase enjoyment.

### What to Expect
| Aspect | Detail |
|--------|--------|
| **Training Style** | **Flexible scheduling**: Days are suggestions. |
| **Intensity** | **Effort-based**: Focus on feeling good. |
| **Pillar Focus** | Running (Med), **Strength (High)**, **Mobility (High)** |
| **Flexibility** | **Very High**: Skip sessions without penalty. |

### Logic
*   **Volume**: 50-66% of previous training volume.
*   **Frequency**: Maintain frequency (e.g. 4x/week) but shorten duration.
*   **Key Session**: One quality session (Long run OR Interval) per week.

---

## 🛠️ Technical Logic

| Feature | Logic Engine |
|---------|--------------|
| Goal Adaptation | [pillar_logic.md](../../../architecture/data_processing/pillar_logic.md) |
| Event Tapering | [events_taper.md](../../../architecture/data_processing/events_taper.md) |
