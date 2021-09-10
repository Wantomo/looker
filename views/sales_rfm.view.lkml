view: sales_rfm {
  drill_fields: [drill_detail*]
  derived_table: {
    # Built for complete RFM mapping
    # date_filter is used for limiting the recency up to the desired month. Default : previous month
    sql:  SELECT
            customer_id,
            MAX(TIMESTAMP_TRUNC(created_at, MONTH)) as date,
            count(increment_id) as count_order,
            SUM(base_grand_total) as total,
            MAX(order_sequence) as order_sequence
          FROM ${sales.SQL_TABLE_NAME}
          WHERE
            order_type = 1 AND
            customer_id is not null AND
            TIMESTAMP_TRUNC(created_at, MONTH) < TIMESTAMP({% date_end date_filter %}) AND
            status IN ('processing','pending','complete','shipped')
          GROUP BY 1
          ;;
  }

  filter: date_filter {
    type: date
  }

  dimension: customer_id {
    description: "Unique ID for each user"
    primary_key: yes
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      date,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date ;;
    convert_tz: no
  }

  dimension: order_sequence {
    description: "Sequence of order per customer"
    type: number
    sql: ${TABLE}.order_sequence ;;
  }

  dimension: count_order {
    type: number
    sql: ${TABLE}.count_order ;;
  }

  dimension: total {
    type: number
    sql: ${TABLE}.total ;;
  }

  measure: count {
    type: count
  }

  measure: sum_total {
    type: sum
    sql: ${total} ;;
  }

  measure: avg_total {
    type: number
    sql: round(avg(${total})) ;;
  }

  measure: sum_count_order {
    type: sum
    sql: ${count_order} ;;
  }

  set: drill_detail {
    fields: [customer_id, date_date, order_sequence]
  }
}
