# Pillar Coordination Overview

> **Implements**: [Pillars](../../ux/product_spec/training/pillars.md)  
> **Detailed Logic**: [Pillar Coordination](../cross_cutting/pillar_coordination.md)  
> **Data Models**: [Workouts](../data_models/_index.md)

**Purpose**: High-level overview of how Running, Strength, and Mobility pillars work together.

## Holistic Training Intelligence

Ash tracks comprehensive data across all three pillars to build a complete picture of training:

### Gap Detection
- "You're running 4x/week but haven't done lower body strength in 10 days"
- "Missing hip mobility work despite increasing running volume"

### Correlation Analysis
- "Your knee pain appears 2 days after heavy squats + long runs in the same week"
- "Performance improves when you maintain consistent mobility work"

### Training Balance Validation
- "Your running volume is appropriate, but you're missing hip mobility work"
- "Strength sessions are well-timed around your key runs"

## Pillar Priorities by Goal

Different goals emphasize different pillars:

| Goal Type | Running | Strength | Mobility |
|-----------|---------|----------|----------|
| Distance Milestone | High | Medium | Medium |
| Time Performance | High | Medium-High | Medium |
| Event | High | Med→Low | Med→High |
| Maintenance | Medium | High | High |

## Core Coordination Principles

1. **Priority-Based Scheduling**: High-priority pillar workouts scheduled first
2. **48-Hour Rule**: Allow recovery between hard efforts in same pillar
3. **Cross-Pillar Awareness**: Avoid conflicting sessions (e.g., hard leg day before key run)
4. **Hard Days Hard, Easy Days Easy**: Never stack high-intensity across pillars

## Detailed Implementation

For complete algorithms and validation logic, see:
- [Pillar Coordination Logic](../cross_cutting/pillar_coordination.md)
- [Calendar & Schedule Management](calendar.md)

## 🗄️ Data Models

| Entity | Schema Definition |
|--------|-------------------|
| Workouts | [Workouts](../data_models/_index.md) |
| Goals | [Goals](../data_models/_index.md) |
