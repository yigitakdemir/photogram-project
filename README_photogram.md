# Photogram
### Instagram-Style Photo Sharing App — Ruby on Rails

**Course:** BUSN 36110 Application Development — University of Chicago Booth School of Business  
**Author:** Yigit Akdemir  
**Stack:** Ruby on Rails · PostgreSQL · Devise · Cloudinary · CarrierWave

---

## Overview

Photogram is a full-stack Instagram-style photo sharing web application built as the guided final project for BUSN 36110 Application Development at Chicago Booth. The course provided a project shell with a comprehensive test suite, and the assignment was to implement the full application logic — models, controllers, associations, authentication, and views — to pass all tests by the submission deadline.

The result is a production-ready Rails application with a fully relational data model, Devise-based authentication, Cloudinary image storage, and a social graph supporting follows, feeds, and content discovery.

---

## Features

- **User Authentication:** Secure sign-up, login, logout, and password reset via Devise
- **Photo Management:** Upload, caption, edit, and delete photos — images stored on Cloudinary via CarrierWave
- **Likes & Comments:** Like/unlike photos and leave comments, with real-time count tracking on both
- **Follow System:** Send, accept, and reject follow requests — public accounts auto-accept, private accounts require manual approval
- **Privacy Controls:** Private account profiles and photos are hidden from non-followers
- **Personalized Feed:** View photos posted by accounts you follow
- **Discover Page:** Explore photos liked by people you follow
- **Liked Photos:** Browse all photos you have personally liked

---

## Data Model

| Model | Key Associations |
|-------|-----------------|
| `User` | has many photos, likes, comments, sent/received follow requests |
| `Photo` | belongs to owner (User); has many likes and comments |
| `Like` | belongs to fan (User) and photo |
| `Comment` | belongs to author (User) and photo |
| `FollowRequest` | belongs to sender and recipient (both Users); status: pending/accepted |

Indirect associations enable clean queries like `user.feed` (photos from followed users) and `user.discover` (photos liked by people you follow), built on top of scoped direct associations.

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Backend | Ruby on Rails |
| Database | PostgreSQL, Active Record ORM |
| Authentication | Devise |
| Image Storage | Cloudinary + CarrierWave uploader |
| Frontend | ERB templates, Bootstrap |
| Deployment Config | Render (`render.yaml` included) |

---

## Setup

```bash
bundle install
rails db:create db:migrate db:seed
bin/dev
```

Requires the following environment variables:

```
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret
DATABASE_URL=your_database_url
```
