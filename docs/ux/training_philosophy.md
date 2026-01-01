# Ash Training Engine - Design & Philosophy

This document outlines the core training philosophies, plan structures, and adaptive logic that power the "Ash" AI Coach.

## 1. Core Training Philosophy

Ash uses a **Hybrid Adaptation Strategy** that balances a user's **current training capacity** (Volume/Experience) with their **specific objectives** (Goal Type).

### **A. Capacity-Based Intensity Distribution**
*   **Beginner & Low Volume (< 30km/week): The Pyramidal Approach**
    *   **Focus:** Consistency and safe volume accumulation.
    *   **Distribution:** 70-80% Easy, 15-25% Moderate (Base Building), 0-5% High.
*   **Intermediate & Advanced (> 40km/week): The Polarized (80/20) Approach**
    *   **Focus:** Breaking plateaus and improving ceiling (VO2 max/Threshold).
    *   **Distribution:** 80% Low Intensity (RPE 3-4), 20% High Intensity (RPE 8-10).

### **B. Goal-Driven Customization**
While capacity determines the *foundation*, the **Goal Type** dictates the *structure* (Phases/Blocks) and the *prescription style* (Time-based vs. Distance-based). Ash merges these two signals to create a tailored path.

### **C. Out of Scope**
Ash focuses on **training prescription**, not:
*   **Nutrition/Meal Planning:** Ash provides general hydration and fueling tips (especially for beginners), but does not create meal plans or prescribe specific diets.
*   **Medical Diagnosis:** Persistent pain or injury requires professional evaluation
*   **Sport-Specific Cross-Training Programs:** Ash is built for running, strength, and mobility—not cycling/swimming coaching (these are only used as low-impact alternatives during injury recovery)

### **D. Goal Types**

Ash supports four primary goal types that determine training plan structure. Each goal type requires different training approaches, intensity distributions, and periodization strategies.

#### **1. Distance Milestone Goals**
*Examples: "Run my first 10K", "Complete a half marathon"*

**Philosophy:** Completion over speed. Build endurance safely and prevent injury. Focus on time-based training and gradual progression to minimize impact stress on newer tissues.

---

#### **2. Time Performance Goals**
*Examples: "Sub-30 minute 5K", "Break 2 hours in the half marathon"*

**Philosophy:** Improve speed and efficiency. Track quantifiable progress through distance-based key workouts and regular benchmarking. Polarized intensity (80/20) is used to maximize high-quality stimuli while ensuring recovery.

---

#### **3. Event Goals (Race-Specific)**
*Examples: "Austin Marathon on Feb 16", "Boston Marathon qualifier"*

**Philosophy:** Peak performance on a specific date. Training is structured into distinct periodized phases (Base, Build, Peak, Taper) to arrive at the start line fresh and optimized.

**Short-Notice Races (<3 weeks):**
*   Skip Build phase, go straight to abbreviated taper
*   Treat as "training race" (lower expectations, useful experience)
*   Offer post-race analysis to inform future training

---

#### **4. Maintenance Goals**
*Examples: "Keep running 3x/week during busy season", "Maintain current fitness while traveling", "Stay active without training stress"*

**Philosophy:** Sustain fitness while prioritizing mental freshness and long-term habit formation. Reduce pressure, maximize enjoyment.

**Workout Prescription:**
*   **Flexible scheduling:** Days are suggestions, not rigid rules
*   **Effort-based:** Focus on how it feels, not hitting specific numbers
*   **Variety encouraged:** Mix in cross-training for fun and recovery

**Intensity Distribution:**
*   85% Easy/Aerobic (RPE 3-4)
*   5% Moderate (RPE 6-7)
*   10% High Intensity (short, sharp efforts to maintain speed)

**Key Workout Types:**
*   **One quality session per week:** Either a long run OR intervals (not both)
*   **Easy runs:** 2-3 short, conversational runs
*   **Strides:** 4-6 × 20-second pickups after easy runs (maintain neuromuscular sharpness)
*   **Cross-training:** Cycling, swimming, or other low-impact cardio
*   **Strength training:** 1-2 sessions per week, compound movements

**Phase Structure:**
*   **No traditional phases** - Consistent "Maintenance" intent throughout.
*   **Volume:** 50-66% of previous training volume
*   **Frequency:** Maintain running frequency (e.g., if you ran 4x/week, keep 4x/week but shorten duration)
*   **Duration:** Can be sustained for 2-8 weeks without significant fitness loss

**Weekly Template Example:**
*   Monday: Rest or mobility
*   Tuesday: Easy run (30 min) + strides
*   Wednesday: Strength training (30-40 min)
*   Thursday: Easy run (30 min)
*   Friday: Rest or cross-training
*   Saturday: Quality session (Long run 60 min OR Intervals 40 min)
*   Sunday: Rest or easy cross-training

**Transition Protocols:**
*   **Entering Maintenance:** Reduce volume by 30-50% in first week, drop to 1-2 key sessions
*   **Exiting Maintenance:** Resume at 80% of pre-maintenance volume, rebuild over 2-3 weeks

**Success Metrics:**
*   Maintaining consistency (showing up for scheduled sessions)
*   Feeling fresh and recovered
*   High "Enjoyment" ratings for completed sessions
*   Injury-free training

**ACWR Range:** 0.7 - 1.0 (intentionally low, avoiding progressive overload)

---

#### **Pillar Coordination & Hybrid Goals**
Ash dynamically balances running, strength, and mobility based on goal type and user priority. For hybrid goals (e.g., "First marathon under 4:00"), Ash prioritizes the event-based structure while applying specific performance targets during key workouts.

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

### **Adaptive Recovery Triggers**
If ACWR exceeds 1.3 or user reports multiple consecutive poor sessions, Ash automatically suggests:
*   Early Recovery Block (immediate shift to recovery intent)
*   Reduce volume by 20-30% for the next 7 days
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

## 5. Plan Structure (Phases & Blocks)

Ash generates plans as a sequence of **Phases**, which are further broken down into **Hydrated Blocks**.

### **Phase Skeleton**
Every plan starts with a "Skeleton"—a long-term timeline of phases leading to the goal.
*   **Dynamic Skeleton**: If life happens, the AI can steal days from a "Base" phase to preserve a "Taper" phase.

### **Training Blocks (The "Liquid" Block)**
A **block** is a logical cluster of workouts (typically 3-10 days) within a phase.

A **Training Block** is a logical cluster of workouts within a Phase. It balances stress and recovery across all three pillars (Running, Strength, Mobility).
 
 #### **Key Training Block Principles**
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

### **Phase-Based Periodization Logic**
Workload progresses through a Phase via standard stress/recovery blocks:
1.  **Intro Block:** Onramp and volume stabilization.
2.  **Progression Block:** Strategic load increase.
3.  **Peak Block:** Intensive adaptation.
4.  **Recovery Block:** Strategic deload (20-30% volume reduction) to allow physiological supercompensation.

---

## 6. Adaptive Logic & Edge Cases

The "Ash Planning Prompts" must handle these scenarios rigorously.

### **A. Missed Workouts & The "Fixed Grid" Philosophy**
Ash treats your training schedule like a **fixed grid**, not a "queue" where everything slides forward. This protects recovery days and ensures the Long Run (the "Big Rock") remains on schedule.

*   **Rule:** "Minor interruptions adapt; major interruptions repair."
*   **Logic (The ≤ 2 Day Decision Matrix)**:
    *   **Easy Run**: **Delete**. Do not try to recover these miles; they are gone.
    *   **Strength Session**: **Consolidate**. Move it to the next **Hard Run** day (Speed or Tempo). Follow the "6-Hour Rule" (Run in AM, Lift in PM).
    *   **Speed/Tempo Run**: **Swap**. Move the hard run to the next scheduled **Strength** day. Downgrade that strength session to core/mobility only.
    *   **Long Run**: **Priority**. Shift the Long Run to the next available day. Cancel/Skip whatever was originally on that day (even if it was strength).

*   **The Constraints**:
    *   **48-Hour Recovery**: No heavy leg strength within 48 hours of a Long Run.
    *   **6-Hour Rule**: Consolidated sessions must be separated by at least 6 hours (Run First).
    *   **No Chain Reactions**: A reschedule cannot push the Long Run into the following week.
    *   **AI Strategic Repair**: For disruptions > 2 days, the AI re-evaluates the entire remaining Phase Skeleton to protect the goal.

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

#### **The Honesty Protocol**
If a user's consistency drops significantly (e.g., > 40% sessions missed in a High-Priority phase), Ash initiates the **Honesty Protocol**:
1.  **Flag the Risk**: "Hey, we've missed a few key sessions. At this rate, hitting our original sub-4:00 goal might not be safe for your legs."
2.  **Offer a Safe Pivot**: "I can adjust our target to a 'Strong Finish' goal, which reduces the intensity but ensures we get you to the finish line healthy. What do you think?"
3.  **Rescale the Skeleton**: The AI re-generates the remaining Phases with the new, safer intent.

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

## 7. Return-to-Training
When returning from a break (planned or unplanned), Ash prioritizes safety by applying a volume ceiling to the first block back. This prevents sudden spikes in ACWR and reduces injury risk.

---

## 8. Plateau Protocols

When progress stalls despite consistent training, Ash suggests strategic interventions.

### **Strength Plateau**
*   **Deload Week:** Reduce volume by 40%, maintain intensity (already built into phase progression)
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
Starting volume is determined by current activity level, mapped to an estimated weekly workload. Week 1-2 feedback is then used to calibrate the plan via the ACWR and RPE signals.
