# Ash Training Engine - Design & Philosophy

This document outlines the core training philosophies, plan structures, and adaptive logic that power the "Ash" AI Coach.

## 1. Core Training Philosophy

We will adopt a **Dynamic Progression Model** that shifts based on user experience level.

### **A. Beginner & Low Volume (< 30km/week): The Pyramidal Approach**
*   **Why:** Beginners often lack the structural durability for high-intensity intervals (Polarized). They need a broad aerobic base and safe "moderate" stimuli to build strength.
*   **Distribution:**
    *   70-80% Easy / Aerobic Base
    *   15-25% Moderate / Threshold (The "Base Building" zone)
    *   0-5% High Intensity
*   **Focus:** Consistency, frequency, and safe volume accumulation.

### **B. Intermediate & Advanced (> 40km/week): The Polarized (80/20) Approach**
*   **Why:** To break plateaus, advanced runners need to polarize their training—keeping easy days truly easy to allow for very hard, high-quality key sessions.
*   **Distribution:**
    *   80% Low Intensity (Zone 1/2)
    *   20% High Intensity (Zone 4/5 - Intervals, Tempo)
*   **Focus:** Improving VO2 max, lactate threshold, and race-specific sharpening.

### **C. Out of Scope**
Ash focuses on **training prescription**, not:
*   **Nutrition/Meal Planning:** Ash provides general hydration and fueling tips (especially for beginners), but does not create meal plans or prescribe specific diets.
*   **Medical Diagnosis:** Persistent pain or injury requires professional evaluation
*   **Sport-Specific Cross-Training Programs:** Ash is built for running, strength, and mobility—not cycling/swimming coaching (these are only used as low-impact alternatives during injury recovery)

## 2. Holistic "Three-Pillar" Integration

Ash treats **Running**, **Strength**, and **Mobility** as first-class citizens, prioritized by the user.

### **Priority & Scheduling Logic**
The user sets a priority (High/Med/Low) for each pillar, and days available.
*   **Optimization:** Ash fills "Big Rocks" (High Priority) first.
*   **Example:** User wants "High Run, Med Lift".
    *   *Schedule:* 4 Runs (Key sessions protected), 2 Lifts.
    *   *Constraint:* Hard Leg Day should NOT be the day before a Long Run.
*   **Recovery Weeks:**
    *   Run volume drops (-20%).
    *   Strength *maintenance* (lower volume, same intensity).
    *   Mobility priority **INCREASES** (extra sessions to aid recovery).

---

## 3. Load Management & Fatigue Monitoring

Ash tracks training stress to prevent overtraining and optimize adaptation.

### **Session RPE (sRPE)**
*   After each session, user rates overall difficulty on a 1-10 scale.
*   **Session Load** = RPE × Duration (minutes)
*   **Weekly Load** = Sum of all session loads
*   *Example:* 7 RPE × 60 min run = 420 AU (Arbitrary Units)

### **Acute:Chronic Workload Ratio (ACWR)**
*   **Acute Load:** Total load from the most recent week
*   **Chronic Load:** Average weekly load over the previous 3-4 weeks
*   **ACWR** = Acute Load ÷ Chronic Load
*   **Safe Zone:** 0.8 - 1.3
    *   **> 1.3:** High injury risk, suggest deload or easier week
    *   **< 0.8:** Undertraining, can safely increase volume

### **Adaptive Deload Triggers**
If ACWR exceeds 1.3 or user reports multiple consecutive poor sessions, Ash automatically suggests:
*   Early recovery week (move Week 4 up)
*   Reduce volume by 20-30% for next week
*   Maintain intensity but shorten duration

---

## 4. Intensity Prescription (RPE-Based)

All sessions are prescribed using **Rate of Perceived Exertion (RPE)** on a 1-10 scale, allowing users to autoregulate based on daily readiness.

### **Running Intensity Zones**
*   **Easy/Aerobic (RPE 3-4):** Conversational pace, can speak in full sentences
*   **Moderate/Tempo (RPE 6-7):** Comfortably hard, can speak in short phrases
*   **Threshold (RPE 7-8):** Hard effort, can only speak a few words
*   **Intervals/VO2 Max (RPE 9):** Very hard, cannot speak

### **Strength Training Intensity**
*   **Reps In Reserve (RIR):** How many more reps could you do?
*   **Easy/Technique (3-4 RIR):** Warm-up sets, skill work
*   **Moderate (2-3 RIR):** Most working sets, sustainable effort
*   **Hard (0-1 RIR):** Key sets for strength gains, occasional use

### **Autoregulation Philosophy**
*   Users adjust weight/pace based on how they feel that day
*   "Hit the prescribed RPE, not the prescribed pace/weight"
*   If feeling strong, push harder; if fatigued, dial back
*   This prevents rigid programming from causing injury or burnout

---

## 5. Plan Structure (The "Deliverables")

Ash will generate plans in **4-Week Mesocycles**.

### **Weekly Microcycle Logic**

A **microcycle** is a single week of training within a mesocycle. It balances stress and recovery across all three pillars (Running, Strength, Mobility).

#### **Key Microcycle Principles**
*   **Hard Days Hard, Easy Days Easy:** Never stack high-intensity sessions back-to-back
*   **48-Hour Recovery Rule:** Allow 48 hours between hard efforts in the same pillar (e.g., Tuesday Intervals → Friday next hard run)
*   **Pillar Coordination:** Avoid hard leg strength the day before a key run (e.g., no heavy squats before Long Run)
*   **Flexibility:** Days are templates, not rigid rules—Ash adjusts based on user availability and priorities

#### **Session Type Definitions**

**Running Sessions:**
*   **Quality Session / Key Session:** High-intensity workouts that drive adaptation (Intervals, Tempo, Hills). These are the "hard days" that require full recovery before and after.
*   **Long Run:** The weekly endurance anchor, typically 20-30% of weekly volume. Builds aerobic base and mental resilience. Usually RPE 4-5 (easy to moderate).
*   **Easy Aerobic Run:** Recovery volume at conversational pace (RPE 3-4). Promotes blood flow and adaptation without adding fatigue.
*   **Shakeout:** Very short (15-20 min), easy-paced run to loosen legs and maintain frequency. Often done the day before a race or key session.

**Strength Sessions:**
*   **Full-Body:** Targets all major muscle groups in one session (squats, deadlifts, push, pull). Efficient for 2-3x/week schedules.
*   **Upper/Lower Split:** Separates upper body (push/pull) and lower body (squat/hinge) into different days. Allows more volume per muscle group.
*   **Maintenance:** Lower volume (1-2 sets per exercise) but same intensity (RPE/RIR). Used during recovery weeks or high-run-volume phases.

**Mobility Sessions:**
*   **Active Mobility:** Dynamic stretches, yoga flows, or movement prep. Can be done before workouts or standalone.
*   **Passive Mobility:** Static stretching, foam rolling, or restorative yoga. Best for recovery days or post-workout.

#### **Sample Microcycle Structure (Running Priority: High, Strength: Medium)**
*   **Monday:** Rest or Passive Mobility (20 min)
*   **Tuesday:** Quality Run 1 (Intervals, RPE 9) + Upper Body Strength (30 min)
*   **Wednesday:** Easy Aerobic Run (RPE 3-4, 40 min)
*   **Thursday:** Quality Run 2 (Tempo, RPE 7-8) OR Easy Run (if fatigued)
*   **Friday:** Active Mobility (20 min) or Rest
*   **Saturday:** Long Run (RPE 4-5, 60-90 min) + Lower Body Strength (light, 2-3 RIR)
*   **Sunday:** Full Rest or Cross-Training (bike, swim)

**Note:** This is a template for a **4-day running week** with **2 strength sessions**. Ash customizes based on user's pillar priorities, available days, and current mesocycle week (Week 1-4).

### **Event-Based Periodization (Race Goal)**

When a user has a target race, Ash structures training into distinct phases leading to a **taper**.

#### **Race Types**

Ash tracks multiple types of racing and athletic events:

| Event Type | Icon/Color | Training Impact | Examples |
|------------|------------|-----------------|----------|
| **Goal Race** | 🏆 Gold star | Primary goal - all training builds toward this | Target marathon, first 10K |
| **Tune-Up Race** | 🎯 Gold outline | Practice race - reduced training 2-3 days before | 5K before marathon, half marathon speed test |
| **Fun Run / Casual Event** | 🏃 Orange dot | Social run - treated as a workout, not a race | Charity 5K, parkrun, team relay |
| **Non-Running Event** | 📅 Purple | Other athletic events | Triathlon, obstacle course, hiking trip |

#### **Smart Planning Around Events**

When an event is added:
1. **Goal Race**: Automatic taper period (reduced volume 1-3 weeks before depending on distance)
2. **Tune-Up Race**: Light training 2-3 days before, recovery day after
3. **Fun Run**: Slight intensity reduction day before, count as workout
4. **Recovery**: Easy week scheduled post-race based on event distance and effort

#### **Phase Structure**
| Phase | Duration | Focus |
|-------|----------|-------|
| **Base** | 4-8 weeks | Volume building, aerobic foundation, injury-proofing |
| **Build** | 4-6 weeks | Race-specific intensity, longer intervals, goal pace work |
| **Peak** | 2-3 weeks | Highest intensity + volume week, sharpening |
| **Taper** | 1-3 weeks | Volume reduction, maintain intensity, freshness |

#### **Taper Protocols by Race Distance**

| Race | Taper Length | Volume Reduction | Intensity |
|------|--------------|------------------|-----------|
| **5K** | 7-10 days | -30% week 1, -50% final 3-4 days | Maintain with short, sharp strides |
| **10K** | 10-14 days | -30% week 1, -50% week 2 | 1-2 short tempo/interval sessions |
| **Half Marathon** | 2 weeks | -30% week 1, -50% week 2 | One race pace tune-up |
| **Marathon** | 3 weeks | -20% W1, -40% W2, -60% W3 | One moderate long run W1, easy thereafter |

#### **Taper Principles**
*   **Reduce volume, NOT intensity:** Keep some fast running to maintain neuromuscular sharpness
*   **Protect sleep and recovery:** This is when adaptation happens
*   **Strength during taper:** Reduce to 1 light maintenance session, no heavy legs in final week
*   **Avoid new stressors:** No new shoes, foods, or training routes race week
*   **Mental preparation:** Ash can offer pre-race confidence prompts

#### **Short Notice Races (<3 weeks out)**
If user adds a race with minimal lead time:
*   Skip Build phase, go straight to abbreviated taper
*   Suggest treating as "training race" (lower expectations, useful experience)
*   Offer post-race analysis to inform future training

### **Monthly Mesocycle Logic (3 Steps Forward, 1 Back)**
1.  **Week 1:** Base Volume
2.  **Week 2:** Progression (+10% volume or added intensity)
3.  **Week 3:** Peak Volume (Hardest week)
4.  **Week 4:** **Recovery / Cutback Week** (Volume reduced by 20-30%, intensity maintained but duration shortened).

---

## 6. Adaptive Logic & Edge Cases

The "Ash Planning Prompts" must handle these scenarios rigorously.

### **A. Missed Workouts**
*   **Rule:** "One missed workout is gone."
*   **Logic:**
    *   Never cram a missed session into a rest day.
    *   If a *Key Session* (Long Run, Interval) is missed:
        *   If user is fresh: Swap it with the next Easy Run.
        *   If user is fatigued: Skip it entirely.
    *   **NEVER** do two hard days back-to-back to "catch up."

### **B. Injury & Pain Management (Adaptive)**
*   **Diagnosis Protocol:**
    *   When user reports pain, Ash asks: "What makes it worse? (Run/Lift/Walk)" and "What makes it better?"
*   **Logic - "Compensate, Don't Just Cut":**
    *   *Scenario:* "Knee hurts when running, but fine when lifting."
    *   *Action:* 
        1.  **Cut High Impact:** Remove/Shorten the run.
        2.  **Boost Low Impact:** Replace with specific *Rehab/Prehab* (e.g., Glute bridges, hip mobility) or Upper Body Strength.
        3.  **Maintain Volume (Optional):** If pain persists after modifications, see cross-training protocol below.

### **Low-Impact Alternatives (Injury Recovery Only)**

Ash does not prescribe low-impact alternatives (cycling, swimming, elliptical) as part of regular programming. These are only suggested when:
1. User reports persistent pain that prevents running
2. Intensity and volume reductions have not resolved the issue
3. User wants to maintain cardiovascular fitness during recovery

**Escalation Protocol:**
*   **Days 1-3 of pain:** Reduce running intensity/volume, add mobility/rehab work
*   **Days 3-5 of pain:** Suggest low-impact alternatives as temporary substitute if user requests it
*   **Days 5+ of pain:** Recommend medical consultation, pause running sessions

**Medical Disclaimer:**
If pain persists beyond 5 days or worsens, Ash will:
*   Recommend seeing a healthcare professional (physiotherapist, sports doctor)
*   Pause all running sessions until user confirms clearance
*   Offer optional strength/mobility for unaffected body parts
*   Provide a "Return from Injury" protocol once cleared (see Section 7)

**Philosophy:** "I'm here to help you train, not diagnose injuries. If something hurts for more than a few days, it's time to see a pro."

**User-Initiated Low-Impact Alternatives:**
If the user proactively asks about cycling, swimming, or elliptical:
> "Cycling/swimming can be a good low-impact alternative if you're dealing with an injury. However, Ash is designed specifically for running, strength, and mobility training. If you're looking to replace running long-term, I'd recommend finding a sport-specific coach or program. If this is just temporary while you heal, let me know what's going on, and we can adjust your plan."

### **C. Vacations**
*   **Short (<1 week):** "Maintenance Mode." Keep the Long Run if possible, otherwise just easy runs for fun (sightseeing). No stress, no notifications.
*   **Long (>2 weeks):** Treat as a "Training Break." On return, re-test or reduce volume by 20% for the first cycle.
*   **Ad-Hoc Exercises:** If user opens app during vacation, they can request optional workouts ("Give me a hotel room strength session"). These don't affect goal metrics.
*   **Notifications:** All training reminders turned off during vacation period.

### **D. The "Swap Engine" (Mood & Pain)**
*   **Scenario 1: Mood Swap:** "I just want to lift today." -> *Logic:* Check cost, allow if not a key session.
*   **Scenario 2: Pain Swap:** "My knee is aching."
    *   *Logic:* **Immediate Override.**
    *   *Action:* Swap today's Run for "Upper Body Strength" or "Knee-Friendly Mobility".
    *   *Ripple Effect:* Flag the next run for a "Pain Check-in" before starting.

### **E. Mental Health & Motivation Days**

When a user wants to skip a workout and doesn't mention illness, injury, or scheduling conflicts, Ash explores motivation before making adjustments.

#### **Detection Triggers**
*   User says: "I don't feel like it today" / "Not in the mood" / "Can I skip?"
*   Multiple skipped sessions without explanation
*   Declining session RPE engagement (not rating workouts)

#### **Conversation Flow**
1.  **Acknowledge without judgment:**
    > "Totally okay to feel that way. Can I ask—what's going on?"
    
2.  **Offer options (not a quiz):**
    > "Are you more tired than usual, stressed about something, or just not feeling motivated?"

3.  **Branch based on response:**

| Response | Ash's Action |
|----------|--------------|
| **"I'm exhausted / burnt out"** | Suggest rest day or light mobility. Check ACWR—may trigger early deload week. |
| **"Stressed / life stuff"** | Offer a "mood boost" workout: short, easy, feel-good (e.g., 20-min walk or light yoga). No pressure. |
| **"Just not motivated"** | Explore further: "Is it this specific workout, or training in general right now?" |
| **"This workout feels boring"** | Offer swap: different exercise, outdoor vs. gym, music/podcast suggestion. |
| **"Training feels pointless"** | Revisit goals: "Let's check in on what you're training for. Has anything changed?" |

#### **Program Adjustments for Low Motivation**
*   **Short-term (1-2 days):** Allow skips or swaps without guilt. "One rest day won't hurt."
*   **Pattern detected (3+ days):** 
    *   Reduce frequency: "Let's try 3 days this week instead of 4."
    *   Shorten sessions: "What if we did 20-minute workouts for a bit?"
    *   Change variety: Introduce new exercises, routes, or cross-training.
*   **Extended slump (1+ weeks):**
    *   Offer "Reset Week": All easy/fun sessions, no performance expectations.
    *   Revisit onboarding goals: "Your goal was X—does that still feel right?"
    *   Suggest Maintenance Mode if life is overwhelming.

#### **Philosophy**
*   **First Skip - Empathetic Exploration:** "Totally okay to feel that way. What's going on?"
*   **Light Pushback with Choice:** "You've had 2 rest days this week. If we skip today, confidence drops to 78%. How about a 15-min walk instead? What feels right?"
*   **Frequent Pattern (3+ skips in 2 weeks):** Dig deeper into root causes—ask about motivation, stress, goal fit
*   **Never Guilt-Trip:** "Missing a workout is not a failure. Let's figure out what works for you."
*   **Distinguish Fatigue from Motivation:** Fatigue = body needs rest. Low motivation = may need novelty, shorter sessions, or goal realignment.
*   **Celebrate Small Wins:** "A 10-minute walk still counts. You moved today."

## 7. Return-to-Training Protocols

When users take breaks (planned or unplanned), Ash asks about the reason and severity to adjust the return.

### **After Illness**
*   **Mild (cold, minor bug):**
    *   Resume at 50% volume
    *   Progress 10-20% per week until back to baseline
*   **Moderate (fever, chest infection):**
    *   Wait until symptom-free for 3-5 days
    *   Resume at 30% volume
    *   Progress 15% per week

### **After Injury**
*   **Minor (1-2 weeks off):**
    *   Resume at 60% volume for affected activities
    *   Maintain other pillars if unaffected
*   **Major (4+ weeks off):**
    *   Treat as beginner for that movement pattern
    *   Rebuild base conservatively

### **After Life Break (vacation, burnout, busy period)**
*   **1-2 weeks:** Resume at 80% volume
*   **3-4 weeks:** Resume at 60% volume
*   **2+ months:** Restart from Week 1 of current mesocycle

### **Maintenance Mode**
For planned busy periods (2-8 weeks), Ash offers a "Maintenance Mode":
*   **Frequency:** 2-3 key sessions per week
*   **Volume:** Cut by 50%
*   **Intensity:** Maintain high intensity (same RPE targets)
*   **Focus:** Compound movements and one quality run (Long Run or Intervals)
*   **Philosophy:** "You won't gain fitness, but you won't lose it either."

---

## 8. Plateau Protocols

When progress stalls despite consistent training, Ash suggests strategic interventions.

### **Strength Plateau**
*   **Deload Week:** Reduce volume by 40%, maintain intensity (already in mesocycle)
*   **Variation Block (2-3 weeks):**
    *   Swap primary lifts for variations (e.g., back squat → front squat, bench → incline bench)
    *   Change rep ranges (if doing 5 reps, try 8-10 reps)
*   **Volume Block (2-3 weeks):**
    *   Increase sets by 20-30%
    *   Slightly lower intensity (add 1 RIR)
    *   Then cut back and retest

### **Running Plateau**
*   **Deload Week:** Standard recovery week
*   **Variation Block (2-3 weeks):**
    *   Swap tempo runs for hill repeats
    *   Replace track intervals with fartlek runs
    *   Add strides or short sprints to easy runs
*   **Volume Block (2-3 weeks):**
    *   Increase weekly mileage by 10-15%
    *   Keep intensity moderate (RPE 6-7 max)
    *   Then return to normal volume with higher intensity

### **General Plateau Philosophy**
*   **First response:** Deload (fatigue masking fitness)
*   **Second response:** Variation (new stimulus)
*   **Third response:** Volume push (build capacity)
*   **Never:** Just "try harder" without changing variables

---

## 9. Supportive Coaching Tone

Ash's personality is a **Supportive Partner**, not a drill sergeant. The goal is long-term consistency and enjoyment.

### **Core Principles**
*   **Celebrate Consistency Over Performance:** "You showed up 4 days this week—that's what matters."
*   **Normalize Setbacks:** "Life happens. Let's adjust the plan, not abandon it."
*   **Reframe Rest:** "Recovery is training. Your body is getting stronger right now."
*   **No Guilt, Ever:** Missed a workout? "One missed session won't derail your progress. Let's focus on what's next."
*   **Encourage Autoregulation:** "How are you feeling today? Let's adjust based on your energy."

### **Examples of Ash's Voice**
*   **After a tough session:** "That was a hard effort—well done for pushing through!"
*   **After a missed workout:** "No worries, we'll keep the plan moving forward."
*   **During a plateau:** "Progress isn't always linear. Let's try a new approach."
*   **During a deload week:** "This week is about recovery, not slacking. Trust the process."

---

## 10. Weather & Environmental Adaptations

Ash adjusts plans based on environmental conditions to keep training safe and effective.

### **Extreme Heat (Heat Index > 90°F / 32°C)**
*   **Suggest:** Move run to early morning or late evening
*   **Adjust:** Reduce intensity by 1 RPE level (e.g., Tempo → Easy)
*   **Swap:** Offer indoor alternatives (treadmill, bike, strength focus)

### **Extreme Cold (Below Freezing with Wind Chill)**
*   **Suggest:** Shorten outdoor duration, add indoor warm-up
*   **Adjust:** Keep intensity moderate to avoid overbreathing cold air
*   **Swap:** Indoor cardio or extended strength session

### **Poor Air Quality (Wildfire Smoke, Pollution)**
*   **Suggest:** Move all outdoor activity indoors
*   **Swap:** Treadmill, stationary bike, or strength-focused day

### **No Safe Outdoor Space (Travel, Dark Mornings, Unsafe Area)**
*   **Suggest:** Hotel gym, bodyweight circuits, or rest day
*   **Adjust:** Prioritize strength or mobility if running isn't feasible

### **Philosophy**
*   "Training is important, but your health and safety come first."
*   "A modified workout is better than a skipped workout or an injury."

---

## 11. Initial Plan Generation

When a user completes onboarding, Ash generates Week 1 using the following inputs:

| Onboarding Input | Mapped To |
|------------------|-----------|
| Goal type | Pillar priority & periodization model (Pyramidal vs. Polarized) |
| Activity level | Starting volume (Chronic Load baseline) |
| Training types enjoyed | Pillar composition & exercise pool |
| Available days | Microcycle structure |
| Injuries/limitations | Movement exclusions + caution flags |
| Event date (if provided) | Periodization phases with taper |

### Starting Volume Estimates

| Activity Level | Est. Weekly Running | Est. Strength Sessions |
|----------------|---------------------|------------------------|
| Just getting started | 10-15 km | 1-2x (short, bodyweight) |
| Casually active | 15-25 km | 2x |
| Regularly training | 25-40 km | 2-3x |
| Very active | 40+ km | 3x |

These are starting points—Ash adjusts based on Week 1-2 feedback (see ACWR in Section 2).

For the full onboarding flow and question details, see [Onboarding Flow](../features/onboarding_flow.md). 
