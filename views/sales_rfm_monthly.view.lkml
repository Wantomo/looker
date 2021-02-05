view: sales_rfm_monthly {
  #Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
            customer_id,
            TIMESTAMP(CONCAT(EXTRACT(YEAR FROM DATETIME(created_at,"Asia/Tokyo")), '-', LPAD(CAST(EXTRACT(MONTH FROM DATETIME(created_at,"Asia/Tokyo")) AS STRING),2,'0'), '-','01')) as date,
            count(order_id) as count_order,
            SUM(base_grand_total) as total,
            MAX(customer_group) as customer_group,
            FROM ${sales_sequence.SQL_TABLE_NAME}
            group by 1, 2
           ;;
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
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date ;;
  }

  dimension: yyyymm {
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension: count_order {
    type: number
    sql: ${TABLE}.count_order ;;
  }

  dimension: total {
    type: number
    sql: ${TABLE}.total ;;
  }

  dimension: customer_group {
    type: string
    sql: ${TABLE}.customer_group ;;
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
}
