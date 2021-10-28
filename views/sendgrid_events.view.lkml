# The name of this view in Looker is "Events"
view: sendgrid_events {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `leafy-habitat-174801.dataform_sendgrid.events`;;
  drill_fields: [detail*]

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: bounce {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.bounce_at ;;
    convert_tz: no
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Bounce Reason" in Explore.

  dimension: bounce_reason {
    type: string
    sql: ${TABLE}.bounce_reason ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension_group: click {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.click_at ;;
    convert_tz: no
  }

  dimension: count_click {
    type: number
    sql: ${TABLE}.count_click ;;
  }

  dimension: count_open {
    type: number
    sql: ${TABLE}.count_open ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: deferred {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.deferred_at ;;
    convert_tz: no
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
    convert_tz: no
  }

  dimension_group: dropped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.dropped_at ;;
    convert_tz: no
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: email_domain {
    type: string
    sql: ${TABLE}.email_domain ;;
  }

  dimension: message_id {
    type: string
    sql: ${TABLE}.message_id ;;
    primary_key: yes
  }

  dimension_group: open {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.open_at ;;
    convert_tz: no
  }

  dimension_group: processed {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.processed_at ;;
    convert_tz: no
  }

  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: count {
    type: count
  }

  # These sum and average measures are hidden by default.
  # If you want them to show up in your explore, remove hidden: yes.
  measure: count_processed {
    type: count
    filters: [processed_date: "-NULL"]
  }

  measure: count_delivered {
    type: count
    filters: [delivered_date: "-NULL"]
  }

  measure: count_opened {
    type: count
    filters: [open_date: "-NULL"]
  }

  measure: count_clicked {
    type: count
    filters: [click_date: "-NULL"]
  }

  measure: count_dropped {
    type: count
    filters: [dropped_date: "-NULL"]
  }

  measure: count_deferred {
    type: count
    filters: [deferred_date: "-NULL"]
  }

  measure: count_bounced {
    type: count
    filters: [bounce_date: "-NULL"]
  }

  set: detail {
    fields: [email, customer_id, processed_time, message_id]
  }
}
