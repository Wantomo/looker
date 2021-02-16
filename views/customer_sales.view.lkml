view: customer_sales {
  derived_table: {
    sql:  SELECT
              customer_id,
              SUM(base_grand_total) as lifetime_sales,
              MIN(created_at) as first_order_date
          FROM ${sales.SQL_TABLE_NAME}
          WHERE status IN ('processing', 'pending', 'complete', 'shipped')
          GROUP BY 1
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
  }

  dimension: lifetime_sales {
    type: number
    sql: ${TABLE}.lifetime_sales ;;
  }

  measure: total_lifetime_sales {
    type: sum
    sql: ${lifetime_sales} ;;
  }
}
