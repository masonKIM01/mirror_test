view: cashback_map {
  derived_table: {
    sql: select
      case
      when b.cashback_rate = 0 then '0'
      when b.cashback_rate < 0.01 then '1'
      when b.cashback_rate between 0.01 and 0.019999 then '2'
      when b.cashback_rate between 0.02 and 0.029999 then '3'
      when b.cashback_rate between 0.03 and 0.039999 then '4'
      when b.cashback_rate between 0.04 and 0.049999 then '5'
      when b.cashback_rate between 0.05 and 0.059999 then '6'
      when b.cashback_rate between 0.06 and 0.069999 then '7'
      when b.cashback_rate between 0.07 and 0.079999 then '8'
      when b.cashback_rate between 0.08 and 0.089999 then '9'
      when b.cashback_rate between 0.09 and 0.099999 then '1'
      when b.cashback_rate between 0.1 and 0.109999 then '10'
      when b.cashback_rate between 0.11 and 0.119999 then '11'
      when b.cashback_rate between 0.12 and 0.129999 then '12'
      when b.cashback_rate between 0.13 and 0.139999 then '13'
      when b.cashback_rate between 0.14 and 0.149999 then '14'
      when b.cashback_rate between 0.15 and 0.159999 then '15'
      when b.cashback_rate between 0.16 and 0.169999 then '16'
      when b.cashback_rate between 0.17 and 0.179999 then '17'
      when b.cashback_rate between 0.18 and 0.189999 then '18'
      when b.cashback_rate between 0.19 and 0.199999 then '19'
      when b.cashback_rate >= 0.2 then '20'
      end as cashback_rate,
      case
      when b.checkout = 0 then '0'
      when b.checkout < 10000 then '~10,000'
      when b.checkout between 10000 and 29999 then '10,000~30,000'
      when b.checkout between 30000 and 49999 then '30,000~50,000'
      when b.checkout between 50000 and 69999 then '50,000~70,000'
      when b.checkout between 70000 and 99999 then '70,000~100,000'
      when b.checkout between 100000 and 149999 then '100,000~150,000'
      when b.checkout between 150000 and 199999 then '150,000~200,000'
      when b.checkout between 200000 and 249999 then '200,000~250,000'
      when b.checkout between 250000 and 299999 then '250,000~300,000'
      when b.checkout between 300000 and 499999 then '300,000~500,000'
      when b.checkout between 500000 and 699999 then '500,000~700,000'
      when b.checkout between 700000 and 999999 then '700,000~1,000,000'
      when b.checkout between 1000000 and 1499999 then '1,000,000~1,500,000'
      when b.checkout between 1500000 and 1999999 then '1,500,000~2,000,000'
      when b.checkout >= 2000000 then '2,000,000~'
      end as checkout,
      b.user_id
      from
      (
      select
        a.user_id,
        a.checkout,
        trunc(1.0* a.cashback / a.checkout,3) as cashback_rate
      from
        (select
          p.user_id,
          sum(p.cashback_amount) as cashback,
          sum(p.checkout_amount) as checkout
        from chai_card_chai_prod_public.payment p
        inner join chai_card_chai_prod_public.merchant m on m.id = p.merchant_id
        where p.status = 'confirmed'
        and p.year = '2022'
        and p.month = '1'
        and m.name = '차이카드'
        group by 1
        )a
      )b
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: users {
    type: count_distinct
    sql: ${TABLE}.user_id ;;
  }

  dimension: cashback_rate {
    type: string
    sql: ${TABLE}.cashback_rate ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: checkout {
    type: string
    sql: ${TABLE}.checkout ;;
  }

  dimension: count_ {
    type: number
    sql: ${TABLE}.count ;;
  }

  set: detail {
    fields: [user_id, cashback_rate, checkout, count_]
  }
}
