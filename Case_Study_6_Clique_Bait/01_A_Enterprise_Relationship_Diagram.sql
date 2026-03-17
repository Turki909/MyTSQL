/* ---------------------------------------------------------------------------
-- Case Study #6: Clique Bait
-- Section A: Enterprise Relationship Diagram
-- Author: Turki Alajmi
-- Date: March 2026
-- Tool used: Microsoft SQL Server (T-SQL)
--------------------------------------------------------------------------- */

/* ---------------------------------------------------------------------------
-- CONTEXT & GRAIN:
-- Clique Bait is an online seafood store. The goal is to calculate funnel
-- fallout rates and track user journeys across the website.
--
-- The database consists of 5 tables:
-- 1. users: Tracks unique customers via cookie_id.
-- 2. events: Logs every single action a user takes on the site.
-- 3. event_identifier: Maps event types (e.g., 1 = Page View, 2 = Add to Cart).
-- 4. page_hierarchy: Maps page IDs to actual product names and categories.
-- 5. campaign_identifier: Tracks marketing campaign dates.
--------------------------------------------------------------------------- */

------------------------------------------------------------------------
-- Q1: Using the DDL schema details, create an ERD for all the Clique Bait datasets.
------------------------------------------------------------------------

/*
  ERD built in dbdiagram.io
  Interactive version: https://dbdiagram.io/d/Clique-Bait-69b87ea878c6c4bc7afa3d82
  Static image: See Case_Study_6_Clique_Bait/Case6_ERD.png in this repo

  TABLE clique_bait.event_identifier {
  event_type INT
  event_name VARCHAR(13)
}

 TABLE clique_bait.campaign_identifier {
  campaign_id INT
  products VARCHAR(3)
  campaign_name VARCHAR(33)
  start_date DATETIME2
  end_date DATETIME2

 Note: 'No FK relationship. products column stores a range string (e.g. 1-3) not a scalar ID. Relationship is resolved at query time via date range logic.'

}

 TABLE clique_bait.page_hierarchy {
  page_id INT
  page_name VARCHAR(14)
  product_category VARCHAR(9)
  product_id INT
}

 TABLE clique_bait.users {
  user_id INT
  cookie_id VARCHAR(6)
  start_date DATETIME2
}

 TABLE clique_bait.events {
  visit_id VARCHAR(6)
  cookie_id VARCHAR(6)
  page_id INT
  event_type INT
  sequence_number INT
  event_time DATETIME2
}

Ref: "clique_bait"."event_identifier"."event_type" < "clique_bait"."events"."event_type"

Ref: "clique_bait"."page_hierarchy"."page_id" < "clique_bait"."events"."page_id"

Ref: "clique_bait"."users"."cookie_id" < "clique_bait"."events"."cookie_id"

 */
