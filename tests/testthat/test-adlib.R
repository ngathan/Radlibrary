# Copyright (c) Facebook, Inc. and its affiliates.
# All rights reserved.
test_that("build_query enforces argument requirements", {
  expect_error(adlib_build_query(ad_reached_countries = "US"), "At least one")
  expect_error(adlib_build_query(search_page_ids = 123), "missing")
  expect_error(adlib_build_query(search_terms = "asdf"), "missing")
})

test_that("build_query returns a list as expected", {
  expect_equal(
    adlib_build_query("US", search_terms = "Facebook"),
    list(
      ad_active_status = "ACTIVE", ad_reached_countries = "['US']",
      ad_type = "POLITICAL_AND_ISSUE_ADS", bylines = NULL, impression_condition = "HAS_IMPRESSIONS_LIFETIME",
      publisher_platform = "['FACEBOOK']", search_page_ids = NULL,
      search_terms = "Facebook", fields = "ad_snapshot_url,ad_creation_time,ad_creative_body,ad_creative_link_caption,ad_creative_link_description,ad_creative_link_title,ad_delivery_start_time,ad_delivery_stop_time,currency,funding_entity,page_id,page_name,spend,impressions",
      limit = 1000
    )
  )
})

test_that("fields works", {
  expect_equal(adlib_fields("ad_data"), "ad_snapshot_url,ad_creation_time,ad_creative_body,ad_creative_link_caption,ad_creative_link_description,ad_creative_link_title,ad_delivery_start_time,ad_delivery_stop_time,currency,funding_entity,page_id,page_name,spend,impressions")
  expect_equal(adlib_fields("demographic_data"), "ad_snapshot_url,demographic_distribution")
  expect_equal(adlib_fields(c("ad_snapshot_url", "ad_creative_link_title", "ad_delivery_start_time")), "ad_snapshot_url,ad_creative_link_title,ad_delivery_start_time")
  expect_error(adlib_fields("dsafdas"))
  expect_error(adlib_fields(c("demographic_data", "ad_data")))
  expect_error(adlib_fields(c("ad_creative_link_title"), "fields"))
})
