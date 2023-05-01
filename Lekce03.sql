-- Funkce COUNT()

-- Úkol 1:

SELECT
	count(1)
FROM czechia_price cp;

-- Úkol 2:

SELECT
	count(`id`) AS `rows_count`
FROM czechia_payroll cp;

-- Úkol 3:

SELECT
	count(`id`) AS `rows_of_known_employees`
FROM czechia_payroll cp
WHERE 
	`value_type_code` = 316
	AND `value` IS NOT NULL;
	
-- Úkol 4:

SELECT
	category_code,
	count(id) AS rows_in_category
FROM czechia_price cp
GROUP BY category_code;

-- Úkol 5:

SELECT
	`category_code`,
	YEAR(`date_from`) AS `year_of_entry`,
	count(`id`) AS `rows_in_category`
FROM czechia_price cp
GROUP BY
	`category_code`,
	`year_of_entry`
ORDER BY
	`year_of_entry`,
	`category_code`;

-- Funkce SUM()

-- Úkol 1:

SELECT
	sum(`value`) AS `value_sum`
FROM czechia_payroll cp
WHERE `value_type_code` = 316;

-- Úkol 2:

SELECT
	`category_code`,
	sum(`value`) AS `sum_of_average_prices`
FROM czechia_price cp
WHERE `region_code` = 'CZ064'
GROUP BY `category_code`;

-- Úkol 3:

SELECT
	sum(`value`) AS `sum_of_average_prices`
FROM czechia_price cp
WHERE `date_from` = '2018-01-15';

-- Úkol 4:

SELECT
	`category_code`,
	count(1) AS `row_count`,
	sum(`value`) AS `sum_of_average_prices`
FROM czechia_price cp
WHERE YEAR(`date_from`) = 2018
GROUP BY `category_code`;

-- Další agregační funkce

-- Úkol 1:

SELECT
	max(`value`)
FROM czechia_payroll cp
WHERE `value_type_code` = 5958;

-- Úkol 2:

SELECT
	`category_code`,
	min(`value`)
FROM czechia_price cp
WHERE YEAR (`date_from`) BETWEEN 2015 AND 2017
GROUP BY `category_code`;

-- Úkol 3:

SELECT
	`industry_branch_code`
FROM czechia_payroll cp
WHERE `value` IN (
	SELECT
		max(`value`)
	FROM czechia_payroll cp2
	WHERE `value_type_code` = 5958
);

SELECT
	*
FROM czechia_payroll_industry_branch cpib
WHERE `code` IN (
	SELECT
		`industry_branch_code`
	FROM czechia_payroll cp
	WHERE `value` IN (
		SELECT
			max(`value`)
		FROM czechia_payroll cp2
		WHERE `value_type_code` = 5958
	)
);

-- Úkol 4:

SELECT
	`category_code`,
	min(`value`),
	max(`value`),
	CASE
		WHEN max(`value`) - min(`value`) < 10 THEN 'Rozdíl do 10 Kč'
		WHEN max(`value`) - min(`value`) < 40 THEN 'Rozdíl do 40 Kč'
		ELSE 'Rozdíl nad 40 Kč'
	END AS `difference`
FROM czechia_price cp
GROUP BY `category_code`
ORDER BY `difference`;

-- Úkol 5:

SELECT
	`category_code`,
	min(`value`) AS `historical_minimum`,
	max(`value`) AS `historical_maximum`,
	round(avg(`value`), 2) AS `average`
FROM czechia_price cp
GROUP BY `category_code`;

-- Úkol 6:

SELECT
	`category_code`,
	`region_code`,
	min(`value`) AS `historical_minimum`,
	max(`value`) AS `historical_maximum`,
	round(avg(`value`), 2) AS `average`
FROM czechia_price cp
GROUP BY
	`category_code`,
	`region_code`
ORDER BY `average` DESC;

-- Další operace v klauzuli SELECT 

-- Úkol 1:

SELECT sqrt(-16);
SELECT 10 / 0;
SELECT floor(1.56);
SELECT floor(-1.56);
SELECT ceil(1.56);
SELECT ceil(-1.56);
SELECT round(1.56);
SELECT round(-1.56);

-- Úkol 2:

SELECT
	`category_code`,
	round(sum(`value`) / count(`value`), 2) AS `average_price`
FROM czechia_price cp
GROUP BY `category_code`
ORDER BY `average_price`;

-- Úkol 3:

SELECT 1;
SELECT 1.0;
SELECT 1 + 1;
SELECT 1 + 1.0;
SELECT 1 + '1';
SELECT 1 + 'a';
SELECT 1 + '12tatata';

-- Úkol 4:

SELECT concat('Hi, ', 'Engeto lektor here!');

SELECT
	concat('We have ', count(DISTINCT `category_code`), ' price categories.') AS `info`
FROM czechia_price cp;

SELECT
	`name`,
	substring(`name`, 1, 2) AS `prefix`,
	substring(`name`, -2, 2) AS `suffix`,
	length(`name`)
FROM czechia_price_category cpc;

-- Úkol 5:

SELECT 5 % 2;
SELECT 14 % 5;
SELECT 15 % 5;

SELECT 123456789874 % 11;
SELECT 123456759874 % 11;

-- Úkol 6:

SELECT
	`country`,
	`year`,
	`population`,
	`population` % 2 AS `division_rest`
FROM economies e
WHERE `population` IS NOT NULL;

SELECT
	`country`,
	`year`,
	`population`,
	NOT `population` % 2 AS `is_even`
FROM economies e
WHERE `population` IS NOT NULL;

SELECT
	`country`,
	`year`,
	`population`,
	NOT `population` % 2 AS `is_even`
FROM economies e
WHERE
	`population` IS NOT NULL
	AND `population` % 2 = 0;

-- BONUSOVÁ CVIČENÍ

-- Countries: Další cvičení

-- Úkol 1:

SELECT
	`continent`,
	sum(`population`) AS `total_population`
FROM countries c
WHERE `continent` IS NOT NULL
GROUP BY `continent`
ORDER BY `total_population`;

SELECT
	`continent`,
	round(avg(`surface_area`)) AS `avg_surface_area`
FROM countries c
WHERE `continent` IS NOT NULL
GROUP BY `continent`
ORDER BY `avg_surface_area`;

SELECT
	`religion`,
	count(*) AS `number_of_countries`
FROM countries c
WHERE `religion` IS NOT NULL
GROUP BY `religion`
ORDER BY `number_of_countries`;

-- Úkol 2:

SELECT
	`continent`,
	sum(`population`) AS `total_population`,
	round(avg(`population`)) AS `avg_population`,
	count(*) AS `number_of_countries`
FROM countries c
WHERE `continent` IS NOT NULL
GROUP BY `continent`
ORDER BY `total_population`;

SELECT
	`continent`,
	round(sum(`surface_area`)) AS `total_surface_area`,
	round(avg(`surface_area`)) AS `avg_surface_area`
FROM countries c
WHERE `continent` IS NOT NULL
GROUP BY `continent`
ORDER BY `total_surface_area`;

SELECT
	`religion`,
	sum(`population`) AS `total_population`,
	count(*) AS `number_of_countries`
FROM countries c
WHERE `religion` IS NOT NULL
GROUP BY `religion`
ORDER BY `total_population`;

-- Úkol 3:

SELECT
	`continent`,
	round(sum(`landlocked`) / count(*) * 100) AS `%_of_landlocked_countries`,
	round(sum(`landlocked` * `population`) / sum(`population`) * 100) AS `%_of_population_in_landlocked_countries`,
	round(sum(`landlocked` * `surface_area`) / sum(`surface_area`) * 100) AS `%_of_surface_area_in_landlocked_countries`
FROM countries c
WHERE `continent` IS NOT NULL
GROUP BY `continent`
ORDER BY `continent`;

-- Úkol 4:

SELECT
	`continent`,
	`region_in_world`,
	sum(`population`) AS `total_population`
FROM countries c
WHERE
	`continent` IS NOT NULL
	AND `region_in_world` IS NOT NULL
GROUP BY
	`continent`,
	`region_in_world`
ORDER BY
	`continent`,
	`total_population` DESC;

-- Úkol 5:

SELECT
	`continent`,
	`religion`,
	sum(`population`) AS `total_population`,
	count(*) AS `number_of_countries`
FROM countries c
WHERE
	`continent` IS NOT NULL
	AND `religion` IS NOT NULL
GROUP BY
	`continent`,
	`religion`
ORDER BY
	`continent`,
	`total_population` DESC;

-- Úkol 6:

SELECT
	`region_in_world`,
	round(sum(`surface_area`) * `yearly_average_temperature` / sum(`surface_area`) , 2) AS `avg_regional_temperature`
FROM countries c
WHERE 
	`yearly_average_temperature` IS NOT NULL
	AND `continent` = 'Africa'
GROUP BY `region_in_world`;

-- COVID-19: funkce SUM()

-- Úkol 1:

SELECT
	*,
	`confirmed` - `recovered` / 2 AS `novy_sloupec`
FROM covid19_basic cb
ORDER BY `date` DESC;

-- Úkol 2:

SELECT
	sum(`recovered`)
FROM covid19_basic cb
WHERE `date` = '2020-08-30';

-- Úkol 3:

SELECT
	sum(`confirmed`),
	sum(`recovered`)
FROM covid19_basic cb
WHERE `date` = '2020-08-30';

-- Úkol 4:

SELECT
	sum(`confirmed`) - sum(`recovered`)
FROM covid19_basic cb
WHERE `date` = '2020-08-30';

-- Úkol 5:

SELECT
	`confirmed`
FROM covid19_basic_differences cbd
WHERE
	`date` = '2020-08-30'
	AND `country` = 'Czechia';

-- Úkol 6:

SELECT
	`country`,
	sum(`confirmed`)
FROM covid19_basic_differences cbd
WHERE 
	`date` >= '2020-08-01'
	AND `date` <= '2020-08-31'
GROUP BY `country`;

-- Úkol 7:

SELECT
	`country`,
	sum(`confirmed`)
FROM covid19_basic_differences cbd
WHERE
	`country` IN ('Czechia', 'Slovakia', 'Austria')
	AND `date` >= '2020-08-20'
	AND `date` <= '2020-08-31'
GROUP BY `country`;

-- Úkol 8:

SELECT
	`country`,
	max(`confirmed`) 
FROM covid19_basic_differences cbd
GROUP BY `country`;

-- Úkol 9:

SELECT
	`country`,
	max(`confirmed`) 
FROM covid19_basic_differences cbd
WHERE `country` LIKE 'C%'
GROUP BY `country`;

-- Úkol 10:

SELECT
	`date`,
	`country`,
	`confirmed`
FROM covid19_basic_differences cbd
WHERE
	`country` IN (
		SELECT
			`country`
		FROM lookup_table lt
		WHERE `population` > 50000000
	)
	AND `date` >= '2020-08-01'
GROUP BY
	`date`,
	`country`
ORDER BY `date`;

-- Úkol 11:

SELECT
	sum(`confirmed`)
FROM covid19_detail_us_differences cdud
WHERE `province` = 'Arkansas';

-- Úkol 12:

SELECT
	`province`,
	`population`
	FROM lookup_table lt
WHERE
	`country` = 'Brazil'
	AND `province` IS NOT NULL
ORDER BY `population` DESC
LIMIT 1;

-- Úkol 13:

SELECT
	`date`,
	sum(`confirmed`) AS `total_confirmed`,
	round(avg(`confirmed`), 2) AS `avg_confirmed`
FROM covid19_basic_differences cbd
GROUP BY `date`
ORDER BY `date` DESC;

-- Úkol 14:

SELECT
	`province`,
	sum(`confirmed`) AS `total_confirmed`
FROM covid19_detail_us cdu
WHERE `date` = '2020-08-30'
GROUP BY `province`
ORDER BY `total_confirmed` DESC;

-- Úkol 15:

SELECT
	`date`,
	`country`,
	`confirmed`
FROM covid19_basic_differences cbd;
 
-- COVID-19: funkce AVG() a COUNT()

-- Úkol 1:

SELECT
	avg(`population`)
FROM lookup_table lt
WHERE 
	`lat` >= 60
	AND `province` IS NULL;

-- Úkol 2:

SELECT
	round(avg(`population`)),
	max(`population`),
	min(`population`),
	count(1),
	round(max(`population`) / min(`population`)) AS `max_min_ratio`
FROM lookup_table lt
WHERE
	`lat` >= 60
	AND `province` IS NULL;

-- Úkol 3:

SELECT
	`religion`,
	round(avg(`population`)) AS `avg_population`,
	round(avg(`surface_area`)) AS `avg_surface_area`,
	count(1) AS `number_of_countries`
FROM countries c
WHERE `religion` IS NOT NULL
GROUP BY `religion`;

-- Úkol 4:

SELECT
	count(1) AS `number_of_countries`,
	max(`population`) AS `max_population`,
	min(`population`) AS `min_population`
FROM countries c
WHERE lower(`currency_name`) LIKE lower('%dollar%');

-- Úkol 5:

SELECT
	`continent`,
	count(`country`)
FROM countries c
WHERE `currency_code` = 'EUR'
GROUP BY `continent`;

-- Úkol 6:

SELECT
	count(`avg_height`) AS `number_of_countries_with_average_height`
FROM countries c;

-- Úkol 7:

SELECT
	`continent`,
	round(avg(`avg_height`), 2) AS `avg_height`
FROM countries c
WHERE `avg_height` IS NOT NULL
GROUP BY `continent`
ORDER BY `avg_height` DESC;

-- Úkol 8:

CREATE OR REPLACE VIEW v_radek_v_population_density AS
	SELECT
		`region_in_world`,
		round(avg(`population_density`), 2) AS `simple_avg_density`,
		round(sum(`surface_area` * `population_density`) / sum(`surface_area`), 2) AS `weighted_avg_density`
	FROM countries c
	WHERE 
		`region_in_world` IS NOT NULL
		AND `population_density` IS NOT NULL
	GROUP BY `region_in_world`;

-- Úkol 9:

SELECT
	*,
	round(abs(`simple_avg_density` - `weighted_avg_density`), 2) AS `diff_avg_density`
FROM v_radek_v_population_density vrvpd
ORDER BY `diff_avg_density`;

-- Úkol 10:

SELECT
	`country`,
	`population_density`,
	`surface_area`
FROM countries c
WHERE `region_in_world` = 'Western Europe'
ORDER BY `population_density` DESC;

SELECT
	1 AS `Monaco_included`,
	round(avg(`population_density`), 2) AS `simple_avg_density`,
	round(sum(`surface_area` * `population_density`) / sum(`surface_area`), 2) AS `weighted_avg_density`
FROM countries c
WHERE `region_in_world` = 'Western Europe'
UNION
SELECT
	0 AS `Monaco_included`,
	round(avg(`population_density`), 2) AS `simple_avg_density`,
	round(sum(`surface_area` * `population_density`) / sum(`surface_area`), 2) AS `weighted_avg_density`
FROM countries c
WHERE
	`region_in_world` = 'Western Europe'
	AND `country` != 'Monaco';