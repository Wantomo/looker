view: sales_monthly_subscriber {
  derived_table: {
    # Built to analyse monthly subscribers
    sql:
        SELECT
          TIMESTAMP_TRUNC(sales.created_at, MONTH) AS sales_created_month,
          sales.customer_id,
          MIN(order_sequence_food) AS order_sequence,
          MIN(subscription_sequence) AS subscription_sequence
        FROM ${sales.SQL_TABLE_NAME} AS sales
        LEFT JOIN
          ${sales_sequence.SQL_TABLE_NAME} AS sales_sequence
        ON
          sales.entity_id=sales_sequence.entity_id
        WHERE
          sales_sequence.subscription_sequence > 0
          AND sales.is_subscription = 1
          AND sales.status IN ("processing", "pending", "complete", "shipped")
        GROUP BY
          1,
          2  ;;
  }

  dimension_group: created {
    label: "Order"
    type: time
    timeframes: [
      month,
      month_name,
    ]
    sql: ${TABLE}.sales_created_month ;;
    convert_tz: no
  }

  dimension: customer_id {
    label: "Id"
    group_label: "Customer"
    type: number
    sql: ${TABLE}.customer_id ;;
    link: {
      label: "See details"
      url: "/dashboards-next/29?Customer%20ID={{ value }}"
    }
  }

  dimension: order_sequence {
    type: number
    sql: ${TABLE}.order_sequence ;;
  }

  dimension: order_sequence_tier {
    type: tier
    tiers: [1,2,3,5,10,20]
    style: integer
    sql: ${order_sequence} ;;
  }

  dimension: subscription_sequence {
    type: number
    sql: ${TABLE}.subscription_sequence ;;
  }

  dimension: subscription_sequence_tier {
    type: tier
    tiers: [1,2,3,5,10,20]
    style: integer
    sql: ${subscription_sequence} ;;
  }

  measure: unique_user_count {
    label: "Count of Unique User"
    type: count_distinct
    sql: ${customer_id} ;;
  }
}
