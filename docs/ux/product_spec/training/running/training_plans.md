# Running Training Plans

Ash provides tailored running training strategies based on your goal type. Each approach uses different periodization, intensity distribution, and success metrics.

## 1. Distance Milestone Goals
*Examples: "Run my first 10K", "Complete a half marathon", "Run 5 miles without stopping"*

**Philosophy:** Completion over speed. Build endurance safely and prevent injury.

### Training Approach
| Aspect | Detail |
|--------|--------|
| **Training Style** | **Time-based**: "Run for 30 minutes" (reduces pressure for beginners) |
| **Intensity Distribution** | **Pyramidal**: 75-80% Easy, 15-20% Moderate, 0-5% High |
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

### Training Approach
| Aspect | Detail |
|--------|--------|
| **Training Style** | **Distance-based**: "6 × 400m intervals" (specific targets) |
| **Intensity Distribution** | **Polarized (80/20)**: 80% Easy, 20% Hard (Zone 4/5). Minimal "moderate" junk miles. |
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

### Training Approach
| Aspect | Detail |
|--------|--------|
| **Training Style** | **Phased**: Base → Build → Peak → Taper |
| **Intensity Distribution** | Varies by phase. Peak phase has highest intensity. |
| **Flexibility** | **Low** during peak weeks. Missed workouts are not made up. |

### Taper Protocols
| Race Distance | Taper Length | Volume Reduction Protocol |
|---------------|--------------|---------------------------|
| **5K** | 7-10 days | -30% W1, -50% final days |
| **10K** | 10-14 days | -30% W1, -50% W2 |
| **Half Marathon** | 2 weeks | -30% W1, -50% W2 |
| **Marathon** | 3 weeks | -20% W1, -40% W2, -60% W3 |

### Success Metrics
*   Hitting target paces in key workouts
*   Completing peak weeks without injury
*   Arriving at race day fresh and confident

---

## 4. Maintenance Goals
*Examples: "Keep running 3x/week during busy season"*

**Philosophy:** Sustain fitness with minimal effective dose. Reduce pressure, increase enjoyment.

### Training Approach
| Aspect | Detail |
|--------|--------|
| **Training Style** | **Flexible scheduling**: Days are suggestions. |
| **Intensity Distribution** | **Effort-based**: Focus on feeling good. |
| **Flexibility** | **Very High**: Skip sessions without penalty. |

### Training Logic
*   **Volume**: 50-66% of previous training volume
*   **Frequency**: Maintain frequency (e.g. 4x/week) but shorten duration
*   **Key Session**: One quality session (Long run OR Interval) per week

### Success Metrics
*   Maintaining running habit
*   Enjoying runs without pressure
*   Staying injury-free

---

## Workout Types

### Easy Runs
*   **Purpose**: Aerobic base building, recovery
*   **Intensity**: Zone 1-2, conversational pace
*   **Frequency**: 60-80% of weekly runs

### Long Runs
*   **Purpose**: Endurance, mental toughness
*   **Intensity**: Zone 2, comfortable pace
*   **Frequency**: Once per week
*   **Duration**: 20-30% of weekly volume

### Tempo Runs
*   **Purpose**: Lactate threshold improvement
*   **Intensity**: Zone 3-4, "comfortably hard"
*   **Frequency**: Once per week (performance goals)
*   **Duration**: 20-40 minutes at tempo pace

### Intervals
*   **Purpose**: VO2 max improvement, speed
*   **Intensity**: Zone 4-5, hard effort
*   **Frequency**: Once per week (performance goals)
*   **Structure**: 400m-1600m repeats with recovery

### Hills
*   **Purpose**: Strength, power, running economy
*   **Intensity**: Zone 4-5, hard effort
*   **Frequency**: Every 2-3 weeks
*   **Structure**: 6-10 hill repeats (30-90 seconds)

## 🛠️ Technical Logic

| Feature | Logic Engine |
|---------|--------------|
| Plan Generation | [plan_generation.md](../../../architecture/data_processing/plan_generation.md) |
| Event Tapering | [events_taper.md](../../../architecture/data_processing/events_taper.md) |
| Intensity Zones | [intensity.md](../intensity.md) |
