# Onboarding Flow

This document defines how Ash gathers initial user information to generate a safe, personalized Week 1 training plan.

**Philosophy:** *"Get them training in under 2 minutes, refine over time."*

---

## 1. Data Collection Tiers

| Tier | When Collected | Purpose |
|------|----------------|---------|
| **Essential (Day 1)** | During onboarding | Minimum to generate a safe Week 1 plan |
| **Discovered** | Weeks 1-2 | Ash learns from session feedback and adjusts |
| **Optional Deep Dive** | Settings / Profile | For users who want to fine-tune |

---

## 2. Essential Questions (Onboarding Flow)

These are the **6-7 questions** asked during first launch. Keep them visual, tappable, and fast.

### **Q1: What's your main goal?**
*Single select, visual cards*

| Option | Internal Mapping |
|--------|------------------|
| 🏃 **Run farther** | Endurance focus, Running = High priority |
| ⚡ **Run faster** | Performance focus, add intervals/tempo |
| 💪 **Get stronger** | Strength = High priority |
| 🧘 **Move better** | Mobility = High priority, injury prevention |
| 🎯 **Train for an event** | Unlocks event date + distance follow-up |
| 🌱 **Just stay active** | Balanced pillars, consistency focus |

> **UX Note:** "Train for event" should trigger a follow-up for event date and type.

---

### **Q2: How active are you right now?**
*Single select, no jargon*

| Option | Internal Mapping |
|--------|------------------|
| 🛋️ **Just getting started** | 0-1 days/week → Beginner, conservative volume |
| 🚶 **Casually active** | 2-3 days/week → Low-moderate volume |
| 🏃 **Regularly training** | 4-5 days/week → Moderate volume |
| 🔥 **Very active** | 6+ days/week → Higher volume baseline |

> **Why this matters:** Determines starting Chronic Load without asking "What's your weekly mileage?"—most casual users don't know.

---

### **Q3: What types of training do you enjoy?**
*Multi-select, pick all that apply*

- Running / Jogging
- Walking / Hiking
- Weight lifting
- Bodyweight / Home workouts
- Yoga / Mobility
- Cycling / Swimming
- Team sports

> **Internal Use:** Informs pillar composition and cross-training options. If they don't select "Weight lifting," Ash leans toward bodyweight strength.

---

### **Q4: How many days per week can you train?**
*Slider or tappable numbers: 2-7*

Optional follow-up: **Do you have specific rest days?** *(e.g., "I can't train on Sundays")*

> **Internal Use:** This is the biggest constraint for microcycle scheduling. We don't need exact times on Day 1—just availability.

---

### **Q5: Do you have any injuries or limitations?**
*Multi-select with "None" option*

| Option | Internal Mapping |
|--------|------------------|
| None | No restrictions |
| Knee issues | Flag lower body impact, offer modifications |
| Back issues | Flag deadlifts, limit spinal loading |
| Shoulder/arm issues | Flag overhead movements, pushing exercises |
| Currently recovering | Trigger follow-up: what + how long |
| Prefer not to say | Default to cautious programming |

> **UX Note:** "Currently recovering" should ask for more details (type and duration).

---

### **Q6: What equipment do you have access to?**
*Multi-select*

| Option | Internal Mapping |
|--------|------------------|
| Gym with full equipment | Full exercise pool available |
| Home with dumbbells/kettlebells | Limited to DB/KB movements |
| Home with barbell + rack | Compound lifts available |
| Bodyweight only / No equipment | Bodyweight-only exercise pool |
| Treadmill / Stationary bike | Indoor cardio alternatives available |

> **Internal Use:** Constrains strength exercise selection immediately.

---

### **Q7: (Conditional) Got a goal date?**
*Only shown if "Train for an event" was selected in Q1*

- **Event date:** Date picker (with validation for minimum lead time)
- **Event type:** 5K / 10K / Half Marathon / Marathon / Other

> **Internal Use:** Unlocks periodization with Base → Build → Peak → Taper phases. If less than 3 weeks out, warn user and offer "keep it low-pressure" option.

---

## 3. Discovered Over Time (Weeks 1-2)

Ash learns passively from behavior and post-session feedback without asking explicit questions.

| Signal | How Ash Learns | Adjustment Made |
|--------|----------------|-----------------|
| **Actual training volume** | Sessions completed + durations logged | Adjusts Chronic Load baseline |
| **Intensity capacity** | Session RPE ratings (consistently 8+ = hard for them) | Recalibrates "Easy" vs. "Hard" |
| **Preferred session length** | Patterns in logged durations | Suggests 30 vs. 45 vs. 60 min sessions |
| **Schedule flexibility** | Frequency of day swaps | Offers more/less rigid plans |
| **Weak pillars** | Pattern of skipping (e.g., always skips mobility) | Gently nudges or integrates into other sessions |
| **Time of day preference** | Timestamps of completed sessions | Suggests optimal scheduling |

### Example Adaptive Prompts

After Week 1:
> "You crushed it this week! I noticed your easy runs felt harder than expected (avg RPE 5). Want me to adjust your paces?"

After Week 2:
> "I see you prefer morning workouts and often skip standalone mobility. Want me to add 5-min mobility to the end of your runs instead?"

---

## 4. Optional Deep Dive (Settings → Profile)

For power users who want full control, accessible anytime in Settings.

| Setting | Options | Purpose |
|---------|---------|---------|
| **Running pace zones** | Auto (based on easy pace input) / Manual entry | Precise pace targets |
| **Heart rate zones** | Connect wearable / Enter max HR / Skip | HR-based intensity guidance |
| **Strength 1RMs** | Enter known maxes for key lifts | Percentage-based prescription |
| **Injury history (detailed)** | More specific (e.g., "IT band, right side") | Better exercise selection |
| **Preferred session times** | Morning / Afternoon / Evening | Scheduling suggestions |
| **Unit preferences** | km/mi, kg/lbs | Display formatting |
| **Notification preferences** | When to remind, frequency | Engagement tuning |

---

## 5. Mid-Program Adjustments

Users can adjust their plan at any time through these touchpoints:

### **A. Weekly Check-In (Optional)**
Shown at the start or end of each week:
> "How was last week?" (1-5 scale with emoji)  
> "Any changes coming up?" (travel, busy week, feeling great, feeling tired)

This lets Ash proactively adjust the upcoming week.

### **B. Session-Level Swaps**
At any time, user can:
- Tap a session → "Swap for something else"
- Ash offers alternatives matching:
  - Same pillar OR different pillar if they want variety
  - Similar or lower intensity
  - Available equipment

### **C. Plan-Level Adjustments (Settings)**
- **Change pillar priorities:** Shift from Running focus → Strength focus
- **Update available days:** "I can only do 3 days this month"
- **Toggle Maintenance Mode:** For planned busy periods (see [Training Philosophy](../ai/training_philosophy_design.md#maintenance-mode))
- **Report new injury:** Triggers adaptive protocol from Training Philosophy

---

## 6. Edge Cases

| Scenario | Response |
|----------|----------|
| "Just getting started" + "6 days/week" | Clarify: "You're new to structured training but want to be very active—is that right? We'll start with 3-4 quality days and build up." |
| Conflicting equipment (e.g., "Gym" + "No equipment") | Keep both—user may train at home sometimes. Ask context when generating sessions. |
| Skips injury question | Default to cautious programming. Check in after Week 1: "Any aches or pains so far?" |
| Race in < 3 weeks | Warning: "That's soon! Want a quick taper plan, or keep the race low-pressure?" |
| Selects all training types | No problem—Ash will balance based on days available and goal priority. |
| Very low days (2/week) | Focus on compound sessions: "Run + strength" combos, drop standalone mobility (integrate instead). |

---

## 7. Onboarding-to-Plan Mapping

When onboarding is complete, Ash generates Week 1 using this logic:

| Onboarding Input | Maps To |
|------------------|---------|
| Goal type | Pillar priority, periodization model |
| Activity level | Starting volume (Chronic Load baseline) |
| Training types enjoyed | Pillar composition, exercise pool |
| Available days | Microcycle structure (which days, how many) |
| Equipment access | Exercise selection constraints |
| Injuries/limitations | Movement exclusions, caution flags |
| Event date (if any) | Periodization phases with taper |

See [Training Philosophy - Initial Plan Generation](../ai/training_philosophy_design.md) for how these inputs translate to specific training parameters.

---

## 8. UX Design Considerations

| Decision | Recommendation |
|----------|----------------|
| **Progress indicator** | Show subtle progress dots (not "3 of 7") for conversational feel |
| **Skip option** | Allow skipping Q5 (injuries) and Q6 (equipment)—default to safe assumptions |
| **Back button** | Always allow going back to previous question |
| **Visual style** | Large tappable cards with icons, minimal text |
| **Animation** | Smooth transitions between questions, celebrate completion |
| **Account creation** | Delay until after onboarding—let them see value first |

---

## Related Documents

- [Training Philosophy Design](../ai/training_philosophy_design.md) - How Ash uses onboarding data to generate plans
- [Product Specification](../product_spec.md) - Overall product vision and feature overview
