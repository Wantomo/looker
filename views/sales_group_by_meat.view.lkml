view: sales_group_by_meat {
  # view for aggregate item group per entity_id
  derived_table: {
    sql:  SELECT
            sales.entity_id,
            SUM(CASE WHEN sales_item.sku in ('FP-C-S-800', 'FP-B-S-800') THEN qty_ordered ELSE 0 END) as qty_of_800g,
            SUM(CASE WHEN sales_item.sku in ('FP-C-S-150', 'FP-B-S-150') THEN qty_ordered ELSE 0 END) as qty_of_150g,
            SUM(CASE WHEN sales_item.sku in ('FP-B-S-150', 'FP-B-S-800') THEN qty_ordered ELSE 0 END) as qty_of_beef,
            SUM(CASE WHEN sales_item.sku in ('FP-C-S-150', 'FP-C-S-800') THEN qty_ordered ELSE 0 END) as qty_of_chicken
          FROM sales
          LEFT JOIN sales_item ON sales.entity_id = sales_item.order_id
          GROUP BY 1
       ;;
  }

  dimension: entity_id {
    label: "Internal Order Id"
    primary_key: yes
    type: number
    sql: ${TABLE}.entity_id ;;
  }

  dimension: qty_of_800g {
    type: number
    sql: ${TABLE}.qty_of_800g ;;
  }

  dimension: qty_of_150g {
    type: number
    sql: ${TABLE}.qty_of_150g ;;
  }

  dimension: qty_of_beef {
    type: number
    sql: ${TABLE}.qty_of_beef ;;
  }

  dimension: qty_of_chicken {
    type: number
    sql: ${TABLE}.qty_of_chicken ;;
  }

  dimension: meat_type {
    type: string
    sql:  CASE
          WHEN ${qty_of_chicken} = 0 AND ${qty_of_beef} >= 1 THEN 'beef'
          WHEN ${qty_of_chicken} >= 1 AND ${qty_of_beef} = 0 THEN 'chicken'
          WHEN ${qty_of_chicken} >= 1 AND ${qty_of_beef} >= 1 THEN 'mixed'
          END ;;
  }

  dimension: package_type {
    type: string
    sql:  CASE
          WHEN ${qty_of_800g} = 0 AND ${qty_of_150g} >= 1 THEN 'sample'
          WHEN ${qty_of_800g} >= 1 AND ${qty_of_150g} = 0 THEN 'normal'
          WHEN ${qty_of_800g} >= 1 AND ${qty_of_150g} >= 1 THEN 'mixed'
          END ;;
  }
}
