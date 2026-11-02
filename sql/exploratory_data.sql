SELECT * 
FROM galaxy limit(5)

-- Business Operation Questions
-- Q1. How much classification volume could theoretically be reduced by implementing
--	   a 20-classification cap per galaxy?

SELECT
	SUM(classification_count) AS total_classifications,
	SUM(LEAST(classification_count, 20)) AS capped_classifications,
	SUM(classification_count) - SUM(LEAST(classification_count, 20)) AS reduced_classification,
	ROUND(
		(1.0 - (SUM(LEAST(classification_count, 20))::NUMERIC / SUM(classification_count))) * 100,
		2
	) AS percent_reduction
FROM galaxy;

-- Q2. How are galaxies distributed across volunteer participation levels,
--	   and what percentage of total votes does each group represent?

SELECT 
	ROUND(
		(SUM(vote_count)::NUMERIC / (SELECT SUM(vote_count) FROM galaxy)) * 100,
		2
	) AS percentage_of_total_votes,
	ROUND(AVG(classification_count), 2) AS avg_classifications
FROM galaxy
GROUP BY vote_group
ORDER BY 
	CASE vote_group
		WHEN 'Low' THEN 1
		WHEN 'Moderate' THEN 2
		WHEN 'High' THEN 3
		WHEN 'Very High' THEN 4
	END;

-- Q3. What percentage of galaxies fail to reach a 60% debiased fraction
--	   in either primary morphology category?

SELECT
	COUNT(*) AS galaxy_below_60_percent,
	ROUND((COUNT(*)::NUMERIC / (SELECT COUNT(*) FROM galaxy) * 100), 2)AS percentage_below_60_percent
FROM galaxy
WHERE smooth_fraction < 0.60
  AND features_or_disk_fraction < 0.60;

-- Astrophysics Operation Questions
-- Q4. What is the count and percentage distribution of galaxies across
--	   primary morphology categories using a 70% debiased fraction threshold?

SELECT 
	morphology_category,
	COUNT(*) AS galaxy_count,
	ROUND((COUNT(*)::NUMERIC / (SELECT COUNT(*) FROM galaxy)) * 100, 2) AS population_percentage
FROM (
	SELECT 
		CASE 
			WHEN smooth_fraction >= 0.70 THEN 'Elliptical / Smooth'
			WHEN features_or_disk_fraction >= 0.70 AND spiral_fraction >= 0.70 THEN 'Spiral'
			WHEN features_or_disk_fraction >= 0.70 AND spiral_fraction < 0.70 THEN 'Disk / Lower Spiral Fraction'
			ELSE 'Unclear / Mixed Morphology'
		END AS morphology_category
	FROM galaxy
) AS categorized_galaxies
GROUP BY morphology_category
ORDER BY galaxy_count DESC;

-- Q5. How do one-arm and two-arm classification fractions differ across galaxies,
--	   and what proportion have nonzero values for each feature?

SELECT
	COUNT(*) AS total_galaxies,
	ROUND(AVG(one_arm_fraction)::NUMERIC, 4) AS avg_one_arm_fraction,
	ROUND(AVG(two_arm_fraction)::NUMERIC, 4) AS avg_two_arm_fraction,
	ROUND(
		PERCENTILE_CONT(0.50)
		WITHIN GROUP (ORDER BY one_arm_fraction)::NUMERIC, 
		4
	) AS median_one_arm_fractoin,
	ROUND(
		PERCENTILE_CONT(0.50)
		WITHIN GROUP (ORDER BY two_arm_fraction)::NUMERIC, 
		4
	) AS median_two_arm_fractoin,
	COUNT(*) FILTER (
		WHERE one_arm_fraction > 0 
	) AS galaxies_with_one_arm_fraction,
	COUNT(*) FILTER (
		WHERE two_arm_fraction > 0 
	) AS galaxies_with_two_arm_fraction,
	ROUND(
		(
			COUNT(*) FILTER (WHERE one_arm_fraction > 0)::NUMERIC / COUNT(one_arm_fraction)
		) * 100, 
		2
	) AS one_arm_nonzero_percentage,
	ROUND(
		(
			COUNT(*) FILTER (WHERE two_arm_fraction > 0)::NUMERIC / COUNT(two_arm_fraction)
		) * 100, 
		2
	) AS two_arm_nonzero_percentage
FROM galaxy;

-- Q6. What is the distribution of classification counts and votes per galaxy,
--	   and how consistent is participation across the dataset?

SELECT 
	COUNT(*) AS total_galaxies,
	MIN(classification_count) AS min_classification, 
	MAX(classification_count) AS max_classification,
	ROUND(AVG(classification_count), 2) AS avg_classification,
	PERCENTILE_CONT(0.50)
		WITHIN GROUP (ORDER BY classification_count) AS median_classifications,
	ROUND(STDDEV(classification_count)::NUMERIC, 2) AS classification_std_deviation,
	MIN(vote_count) AS min_votes,
	MAX(vote_count) AS max_votes,
	ROUND(AVG(vote_count), 2) AS avg_votes,
	PERCENTILE_CONT(0.50)
		WITHIN GROUP (ORDER BY vote_count) AS median_votes,
	ROUND(STDDEV(vote_count)::NUMERIC, 2)
		AS vote_std_deviation
FROM galaxy;

-- Combination of Business and Astrophysics Questions
-- Q7. How many galaxies have 90% debiased agreement in either primary morphology category,
--	   and how many votes have they received?

SELECT
	CASE
		WHEN smooth_fraction >= 0.90 THEN '90%+ Smooth Fast-Track'
		WHEN features_or_disk_fraction >= 0.90 THEN '90%+ Features / Disk Fraction'
	END AS high_fraction_category,
	COUNT(*) AS galaxy_count,
	SUM(vote_count) AS total_votes,
	ROUND(AVG(vote_count), 2) AS avg_votes_per_galaxy,
	ROUND(AVG(classification_count), 2) AS avg_classifications_per_galaxy
FROM galaxy
WHERE smooth_fraction >= 0.90
   OR features_or_disk_fraction >= 0.90
GROUP BY high_fraction_category
ORDER BY galaxy_count DESC;

-- Q8. How does increasing the primary morphology threshold from 60% to 85% affect
--	   the number of galaxies classified as finalzied versus unresolved?

SELECT
	COUNT(*) AS total_galaxies,
	COUNT(*) FILTER (
		WHERE smooth_fraction >= 0.60
		   OR features_or_disk_fraction >= 0.60
	) AS finalized_at_60_percent,
	COUNT(*) FILTER (
		WHERE smooth_fraction >= 0.60
		   AND features_or_disk_fraction >= 0.60
	) AS finalized_at_60_percent,
	COUNT(*) FILTER (
		WHERE smooth_fraction >= 0.85
		   OR features_or_disk_fraction >= 0.85
	) AS finalized_at_60_percent,
	COUNT(*) FILTER (
		WHERE smooth_fraction < 0.85
		   AND features_or_disk_fraction < 0.85
	) AS finalized_at_60_percent
FROM galaxy;
