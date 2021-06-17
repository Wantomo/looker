view: customer_sales {
  derived_table: {
    sql:
        SELECT
          sales.*,
          tm.increment_id as last_order_id,
          tm.qty_of_800 as last_order_qty_of_800,
          is_subscription as last_order_is_subscription
        FROM (
          SELECT
            customer_id,
            SUM(base_grand_total) AS lifetime_sales,
            MIN(created_at) AS first_order_date,
            MAX(created_at) AS last_order_date,
            MAX(order_sequence) AS order_count,
            MAX(entity_id) AS last_internal_order_id
          FROM
            ${sales.SQL_TABLE_NAME}
          GROUP BY
            1) AS sales
        LEFT JOIN (
          SELECT
            entity_id,
            increment_id,
            last_order_row,
            qty_of_800,
            is_subscription
          FROM (
            SELECT
              entity_id,
              increment_id,
              is_subscription,
              ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY entity_id DESC ) AS last_order_row
            FROM
              ${sales.SQL_TABLE_NAME}) AS sales
          LEFT JOIN (
            SELECT
              order_id,
              SUM(CASE
                  WHEN sku IN ('FP-C-S-800', 'FP-B-S-800') THEN qty_ordered
                ELSE
                0
              END
                ) AS qty_of_800
            FROM
              ${sales_item.SQL_TABLE_NAME}
            GROUP BY
              1) AS item
          ON
            item.order_id = sales.entity_id) tm
        ON
          sales.entity_id = tm.entity_id
     ;;
  }

  dimension: customer_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: first_order_date {
    label: "Date of First Order"
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
    sql: ${TABLE}.first_order_date ;;
    convert_tz: no
  }

  dimension_group: last_order_date {
    label: "Date of Last Order"
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
    sql: ${TABLE}.last_order_date ;;
    convert_tz: no
  }

  dimension: lifetime_sales {
    label: "Lifetime Revenue"
    type: number
    sql: ${TABLE}.lifetime_sales ;;
  }

  dimension: order_count {
    label: "Number of Orders"
    type: number
    sql: ${TABLE}.order_count ;;
  }

  dimension: last_order_qty_of_800 {
    type: number
    sql: ${TABLE}.last_order_qty_of_800 ;;
  }

  dimension: last_order_id {
    type: string
    sql: ${TABLE}.last_order_id ;;
  }

  dimension: last_order_is_subscription {
    type: yesno
    sql: ${TABLE}.last_order_is_subscription = 1 ;;
  }

  dimension: segment {
    label: "Segment"
    description: "Segment of customer based on orders"
    type: string
    sql:  CASE
              WHEN ${order_count} = 1 THEN '1-First Order'
              WHEN ${order_count} = 2 THEN '2-First Repeat'
              WHEN ${order_count} > 2 AND ${order_count} < 5 THEN '3-Repeater'
              WHEN ${order_count} >= 5 THEN '4-Loyal'
              ELSE '0 - No order'
          END ;;
  }

  measure: total_lifetime_sales {
    label: "Sum Lifetime Revenue"
    type: sum
    sql: ${lifetime_sales} ;;
  }

  measure: avg_lifetime_sales {
    label: "Average Lifetime Revenue"
    type: average
    sql: ${lifetime_sales} ;;
    value_format: "0"
  }
}
