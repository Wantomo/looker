view: sales_rfm_accumulative {
  derived_table: {
    sql:  (SELECT
            customer_id,
            potential_churn_date AS date,
            NULL as count_order,
            NULL as total,
            'Potential Churn' AS customer_group,
            NULL AS R,
            R2
          FROM ${sales_rfm_monthly.SQL_TABLE_NAME}
          WHERE
            potential_churn_date IS NOT NULL)
            UNION ALL
            (
              SELECT
                customer_id,
                date,
                count_order,
                total,
                customer_group,
                R,
                R2
              FROM ${sales_rfm_monthly.SQL_TABLE_NAME}
            )
            UNION ALL
            (
              SELECT
                customer_id,
                R2 as date,
                count_order,
                total,
                customer_group,
                R,
                R2
              FROM ${sales_rfm_monthly.SQL_TABLE_NAME}
            )
          ;;
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

  dimension: customer_id {
    description: "Unique ID for each user"
    primary_key: yes
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: customer_group {
    type: string
    sql: ${TABLE}.customer_group ;;
  }

  dimension: customer_group_id {
    type: number
    sql:  CASE
              WHEN ${TABLE}.customer_group = '1-First Order' THEN 1
              WHEN ${TABLE}.customer_group = '2-First Repeat Order' THEN 2
              WHEN ${TABLE}.customer_group = 'Potential Churn' THEN 3
              WHEN ${TABLE}.customer_group = '3-Repeater' THEN 4
              WHEN ${TABLE}.customer_group = '4-Loyal' THEN 5
          END ;;
  }

  measure: count {
    type: count
  }

  measure: count_distinct {
    type: count_distinct
  }
}
