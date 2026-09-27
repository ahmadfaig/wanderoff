# Wanderoff MVP Product & Build Specification

## 1. Product

**Wanderoff** is a travel itinerary product built around three layers:

1. **The Musts**: the destination experiences that are worth seeing.
2. **The Wander**: interesting experiences beyond the obvious tourist path.
3. **Your Way**: experiences adapted to who you are traveling with and what you enjoy.

Core philosophy:

> **See what matters. Wander beyond the obvious. Make the trip your way.**

For the MVP, the product should feel like a curated travel editorial product, not an AI chatbot.

---

## 2. MVP Scope

Build only two page types:

### Page 1: Index

The landing page should include:

- Wanderoff brand/logo text
- Short brand statement
- Short explanation of the three layers
- List/grid of available city trips
- Three initial cities:
  - Tokyo
  - Bangkok
  - Seoul
- Each city card should link to its detail page

### Page 2: City / Itinerary Detail

Create three initial itinerary pages:

- Tokyo, X Days
- Bangkok, X Days
- Seoul, X Days

Use a simple duration for the MVP, such as **5 Days**, but keep the content model easy to change later.

Each detail page contains:

1. City title
2. Trip duration
3. Short subtitle / trip positioning
4. Long storytelling paragraph describing the overall itinerary
5. Day-by-day summary
6. POI section
7. Three tabs:
   - The Musts
   - The Wander
   - Your Way
8. For Your Way:
   - Travel Group selector
   - Travel Style selector
   - POI list updates dynamically

---

## 3. Technology Constraints

Keep the MVP extremely simple.

### Required

- Plain HTML
- Plain CSS
- Minimal vanilla JavaScript for dynamic filtering
- No frontend framework
- No backend
- No database
- No authentication
- No API
- No OTA integration
- No map integration
- No AI integration

The project should be easy to run locally by opening the HTML files or using a very simple static server.

---

# 4. Core Enums

## ItineraryLayer

```csharp
public enum ItineraryLayer
{
    TheMusts,
    TheWander,
    YourWay
}
```

Display labels:

- `TheMusts` → **The Musts**
- `TheWander` → **The Wander**
- `YourWay` → **Your Way**

## TravelGroup

```csharp
public enum TravelGroup
{
    Solo,
    Couple,
    Friends,
    Family
}
```

## TravelStyle

```csharp
public enum TravelStyle
{
    FoodAndDrink,
    Culture,
    Nature,
    Adventure,
    Relaxed,
    Nightlife,
    Shopping
}
```

Display labels:

- `FoodAndDrink` → Food & Drink
- `Culture` → Culture
- `Nature` → Nature
- `Adventure` → Adventure
- `Relaxed` → Relaxed
- `Nightlife` → Nightlife
- `Shopping` → Shopping

---

# 5. Trip Structure

The default MVP trip structure is:

### 5-day trip

- Day 1: The Musts
- Day 2: The Musts
- Day 3: The Wander
- Day 4: Your Way
- Day 5: Your Way

The exact number of days can change later.

The three layers are therefore not simply filters applied to every day. They are the editorial structure of the trip.

## The Musts

Purpose:

> See what you came for.

These should be broadly enjoyable and suitable for different traveler types.

Do not make The Musts exclusively for first-time tourists. A solo traveler, couple, friend group, and family should all be able to enjoy the layer.

## The Wander

Purpose:

> See what you didn't know you were looking for.

The Wander is Wanderoff's signature layer.

It should be less obvious than the standard tourist route, but it must still be genuinely enjoyable.

Avoid recommending obscure places purely because they are obscure.

The Wander can include:

- Neighborhoods
- Independent cafés
- Local food areas
- Small galleries
- Markets
- Workshops
- Interesting streets
- Alternative viewpoints
- Less-touristy cultural experiences
- Short day trips

The Wander should also remain broadly usable by solo travelers, couples, friends, and families.

## Your Way

Purpose:

> Spend the rest of your trip your way.

Your Way is personalized using two dimensions:

### Travel Group

- Solo
- Couple
- Friends
- Family

### Travel Style

- Food & Drink
- Culture
- Nature
- Adventure
- Relaxed
- Nightlife
- Shopping

This creates:

**4 Travel Groups × 7 Travel Styles = 28 combinations**

The system must support all 28 combinations.

However, these are **not 28 completely separate itineraries**.

POIs can overlap between multiple combinations.

The content should be reusable and tagged with multiple groups and styles.

---

# 6. Your Way Data Model

Each POI should conceptually have:

```text
name
description
layer
travelGroups[]
travelStyles[]
day
area
duration
```

Example:

```text
Name: Tsukiji Outer Market

Layer: YourWay

TravelGroups:
- Solo
- Couple
- Friends
- Family

TravelStyles:
- FoodAndDrink
- Culture
```

Another example:

```text
Name: Golden Gai

Layer: YourWay

TravelGroups:
- Solo
- Couple
- Friends

TravelStyles:
- FoodAndDrink
- Nightlife
```

A POI can belong to multiple Travel Groups and multiple Travel Styles.

---

# 7. Your Way Filtering Behavior

The UI should have:

### Travel Group

```text
[ Solo ] [ Couple ] [ Friends ] [ Family ]
```

### Travel Style

```text
[ Food & Drink ]
[ Culture ]
[ Nature ]
[ Adventure ]
[ Relaxed ]
[ Nightlife ]
[ Shopping ]
```

When the user changes either selector, the Your Way POI list should update.

The default selection can be:

```text
Travel Group: Friends
Travel Style: Food & Drink
```

Filtering rule:

A POI appears when:

```text
selected Travel Group is included
AND
selected Travel Style is included
```

For example:

```text
POI.travelGroups contains selectedGroup
AND
POI.travelStyles contains selectedStyle
```

If no POIs match, show a friendly empty state such as:

> We couldn't find a perfect match for this combination yet.

Do not hide the selectors.

---

# 8. Important Content Principle

Do not create four completely different versions of every city itinerary.

Instead, maintain a common destination knowledge base.

For example, Tokyo may have:

```text
50 curated POIs
```

Each POI can be tagged:

```text
Layer
Travel Groups
Travel Styles
```

The Your Way experience then assembles relevant POIs from those building blocks.

This allows substantial overlap.

For example:

**Kiyosumi-Shirakawa**

could be:

- Couple
- Friends
- Solo
- Family

and:

- Food & Drink
- Culture
- Relaxed

This is desirable.

---

# 9. Detail Page Layout

Recommended structure:

```text
------------------------------------------------
WANDEROFF
------------------------------------------------

TOKYO
5 DAYS

A different way to experience Tokyo.

[Long storytelling paragraph]

DAY 1
The Musts
...

DAY 2
The Musts
...

DAY 3
The Wander
...

DAY 4
Your Way
...

DAY 5
Your Way
...

------------------------------------------------
EXPLORE THE ITINERARY
------------------------------------------------

[ THE MUSTS ] [ THE WANDER ] [ YOUR WAY ]

POI LIST
------------------------------------------------
POI card
POI card
POI card
------------------------------------------------
```

For the Your Way tab:

```text
YOUR WAY

Who are you traveling with?

[ Solo ] [ Couple ] [ Friends ] [ Family ]

What are you into?

[ Food & Drink ]
[ Culture ]
[ Nature ]
[ Adventure ]
[ Relaxed ]
[ Nightlife ]
[ Shopping ]

------------------------------------------------

Recommended for:
Friends + Food & Drink

POI cards...
```

---

# 10. Storytelling Section

The storytelling section is important.

It should not read like a database or checklist.

It should tell the story of the trip as a cohesive journey.

Example tone:

> Tokyo can feel overwhelming at first. There is the Tokyo everyone knows, with Shibuya's neon crossing, ancient temples in Asakusa and the endless energy of Shinjuku. We start there, giving you enough of the classics to understand the city without spending your entire trip ticking boxes. Then we take you a little further away from the obvious route, through quieter neighborhoods, independent cafés and streets where Tokyo feels more local. The final days are yours to shape, whether that means chasing great food, slowing down over coffee, exploring contemporary culture or staying out late with friends. By the time you leave, Tokyo should feel less like a list of attractions and more like a place you actually experienced.

The paragraph should be long enough to feel editorial and immersive.

Do not generate generic AI-sounding copy.

---

# 11. Initial City Content

## Tokyo

### Trip

**Tokyo, 5 Days**

Positioning:

> Tokyo beyond the obvious.

### Day 1: The Musts

- Shibuya Crossing
- Meiji Shrine
- Harajuku
- Shinjuku

### Day 2: The Musts

- Senso-ji
- Asakusa
- Ueno
- Akihabara

### Day 3: The Wander

- Shimokitazawa
- Independent cafés
- Vintage shops
- Neighborhood streets
- Local izakaya

### Day 4: Your Way

Possible POIs:

- Tsukiji Outer Market
- teamLab
- Kiyosumi-Shirakawa
- Ebisu
- Daikanyama
- Yanaka
- Golden Gai
- Tokyo Station

### Day 5: Your Way

Use additional or repeated POIs depending on the selected combination.

Example for Friends + Food & Drink:

- Tsukiji Outer Market
- Ebisu
- Daikanyama
- Golden Gai

Example for Family + Relaxed:

- Kiyosumi-Shirakawa
- teamLab
- Tokyo Station
- Easy shopping / café stop

---

## Bangkok

### Trip

**Bangkok, 5 Days**

Positioning:

> Bangkok beyond the obvious.

### Day 1: The Musts

- Grand Palace
- Wat Pho
- Chao Phraya River
- Chinatown

### Day 2: The Musts

- Wat Arun
- Bangkok old town
- Major shopping area
- Evening food experience

### Day 3: The Wander

- Talat Noi
- Song Wat
- Local cafés
- Neighborhood food
- Independent shops

### Day 4: Your Way

Possible POIs:

- Chatuchak
- Jim Thompson House
- Iconsiam
- Ari
- Sukhumvit
- Bangkok Art and Culture Centre
- Rooftop experience
- Thai cooking experience

### Day 5: Your Way

Use the relevant POIs for the selected group/style.

Example for Friends + Nightlife:

- Sukhumvit
- Rooftop experience
- Chinatown food
- Late-night bars

Example for Family + Relaxed:

- Iconsiam
- Thai cooking experience
- Riverside experience
- Early dinner

---

## Seoul

### Trip

**Seoul, 5 Days**

Positioning:

> Seoul beyond the obvious.

### Day 1: The Musts

- Gyeongbokgung
- Bukchon Hanok Village
- Insadong
- Myeongdong

### Day 2: The Musts

- N Seoul Tower / Seoul viewpoint
- Hongdae
- Gangnam
- Korean food experience

### Day 3: The Wander

- Seongsu
- Ikseon-dong
- Small cafés
- Independent stores
- Local neighborhood streets

### Day 4: Your Way

Possible POIs:

- Gwangjang Market
- Seongsu cafés
- Seoul Forest
- Leeum Museum
- Hannam-dong
- Mangwon Market
- Korean cooking experience
- Hongdae nightlife

### Day 5: Your Way

Use the relevant POIs for the selected group/style.

Example for Couple + Culture:

- Leeum Museum
- Hannam-dong
- Ikseon-dong
- Traditional Korean experience

Example for Friends + Food & Drink:

- Gwangjang Market
- Mangwon Market
- Seongsu
- Hongdae

---

# 12. Google Sheets Content Model

The MVP content is maintained in one Google Sheet with exactly three tabs:

```text
Cities
Days
POIs
```

The spreadsheet is the source of truth for itinerary content. The static website reads the same logical content model.

## Cities tab

One row represents one city trip. City-level accommodation is stored on the same row because the MVP has one recommended stay per city.

Required fields:

```text
city_id
city_name
country
duration
positioning
story
image
hotel_name
hotel_area
hotel_price
active
```

Example:

```text
city_id: tokyo
city_name: Tokyo
hotel_name: Hotel Groove Shinjuku
hotel_area: Shinjuku
hotel_price: from $182/night
```

The hotel is not a separate content collection or tab.

## Days tab

One row represents one itinerary day for a city.

Required fields:

```text
city_id
day
layer
title
sort
```

The `layer` value uses the ItineraryLayer values:

```text
TheMusts
TheWander
YourWay
```

## POIs tab

One row represents one curated point of interest. POIs are reusable building blocks and can be tagged with multiple travel groups and styles.

Required fields:

```text
city_id
poi_id
name
layer
day
content_type
description
area
duration
travel_groups
travel_styles
sort
image
active
```

Multiple values in `travel_groups` and `travel_styles` are stored using `|` as the separator. For example:

```text
travel_groups: Solo|Couple|Friends|Family
travel_styles: Food & Drink|Culture
```

The data model therefore supports the same reusable POI across multiple combinations rather than creating separate POIs for each combination.

For the current MVP content, `day` may be blank for POIs that are not explicitly assigned to a particular day. The existing Your Way content is filtered by group and style; the sheet should not invent a day assignment where one has not been defined.

---

# 12. POI Card

Each POI card should contain:

- Name
- Short description
- Optional area
- Optional estimated time
- Optional small image placeholder

Example:

```text
TSUKIJI OUTER MARKET

Start the day with sushi, tamagoyaki and small bites
while exploring the lively streets around Tokyo's
famous former wholesale market.

Tokyo · Food & Drink
```

Keep cards visually simple.

---

# 13. Index Page

The landing page should communicate the concept quickly.

Suggested copy:

## Wanderoff

**Travel beyond the obvious.**

See the places that make a destination worth visiting. Wander into the places you wouldn't have found on your own. Then make the rest of the trip yours.

### Three layers

**THE MUSTS**  
See what you came for.

**THE WANDER**  
See what you didn't know you were looking for.

**YOUR WAY**  
Make the trip yours.

### Cities

**Tokyo**  
Tokyo beyond the obvious.  
5 Days

**Bangkok**  
Bangkok beyond the obvious.  
5 Days

**Seoul**  
Seoul beyond the obvious.  
5 Days

---

# 14. Visual Direction

The design should feel:

- Editorial
- Modern
- Curious
- Travel-focused
- Slightly adventurous
- Premium but not luxurious
- Clean
- Human

Avoid:

- Generic travel booking-site aesthetics
- Heavy dashboards
- Excessive cards
- Overly colorful UI
- AI-chat interface
- Corporate SaaS appearance

The website should feel closer to a **travel magazine that happens to produce useful itineraries**.

---

# 15. Responsive Design

The MVP should work on:

- Desktop
- Tablet
- Mobile

On mobile:

- City cards stack vertically
- Tabs remain easy to tap
- Travel Group options can horizontally scroll or wrap
- Travel Style options can wrap
- POI cards stack vertically
- Storytelling remains readable with comfortable line length

---

# 16. JavaScript Requirements

Use JavaScript only for:

1. Switching the three itinerary tabs.
2. Changing Travel Group.
3. Changing Travel Style.
4. Filtering/rendering Your Way POIs.
5. Updating the selected state in the UI.

Do not introduce a JavaScript framework.

The filtering data can live in a simple JavaScript object/array.

Example:

```javascript
const pois = [
  {
    name: "Tsukiji Outer Market",
    layer: "YourWay",
    groups: ["Solo", "Couple", "Friends", "Family"],
    styles: ["FoodAndDrink", "Culture"]
  }
];
```

---

# 18. Non-Goals

Do NOT build these in the MVP:

- Login
- User accounts
- Saved trips
- AI chat
- AI-generated itinerary
- Dynamic itinerary generation
- Maps
- Flight search
- OTA API integration
- Affiliate links
- Booking
- Reviews
- Ratings
- Comments
- Social features
- Admin CMS
- Database
- Backend API
- Analytics dashboard

The MVP is primarily about validating:

> **Do people want to discover destinations through Wanderoff's Musts + Wander + Your Way structure?**

---

# 19. Acceptance Criteria

The MVP is complete when:

### Index

- [ ] Landing page loads.
- [ ] Wanderoff brand positioning is visible.
- [ ] Three layers are explained.
- [ ] Tokyo, Bangkok and Seoul are listed.
- [ ] Each city links to its detail page.

### Detail

- [ ] Tokyo detail page works.
- [ ] Bangkok detail page works.
- [ ] Seoul detail page works.
- [ ] Each has a long itinerary storytelling section.
- [ ] Each has a day-by-day structure.
- [ ] POIs are displayed.
- [ ] POIs are separated into The Musts, The Wander and Your Way.
- [ ] Tabs switch without a page reload.

### Your Way

- [ ] Four Travel Groups exist.
- [ ] Seven Travel Styles exist.
- [ ] All 28 combinations can be selected.
- [ ] POI results dynamically update.
- [ ] POIs can appear in multiple combinations.
- [ ] POIs can belong to multiple groups/styles.
- [ ] Empty combinations display a sensible message.

### Technical

- [ ] Plain HTML/CSS is used.
- [ ] Vanilla JavaScript only.
- [ ] No framework is required.
- [ ] No backend is required.
- [ ] No database is required.
- [ ] Mobile layout works.
- [ ] Code is simple enough to extend with additional cities and POIs later.

---

# 20. Future Direction

The MVP should be designed so the eventual product can evolve into:

```text
Curated itineraries
        ↓
Your Way personalization
        ↓
Dynamic itinerary generation
        ↓
Live availability / pricing
        ↓
Bookable itinerary
        ↓
Adaptive trip companion
```

The important principle is:

> **AI should eventually compose Wanderoff's travel knowledge, not invent the product's point of view from scratch.**
