-- スキーマの作成
CREATE TABLE plans (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  code VARCHAR(255)
);

CREATE TABLE demand_charges (
  id SERIAL PRIMARY KEY,
  plan_id INTEGER REFERENCES plans(id),
  ampere_from INTEGER,
  ampere_to INTEGER,
  charge INTEGER
);

CREATE TABLE energy_charges (
  id SERIAL PRIMARY KEY,
  plan_id INTEGER REFERENCES plans(id),
  kwh_from INTEGER,
  kwh_to INTEGER,
  rate INTEGER
);

-- plansにデータを投入
DO
$$
DECLARE
    i INT := 0;
    plan_name VARCHAR(255);
    plan_code VARCHAR(255);
BEGIN
    FOR i IN 1..100 LOOP
        plan_name := 'プラン' || CHR(64 + i);
        plan_code := 'plan' || i;
        INSERT INTO plans (name, code) VALUES (plan_name, plan_code);
    END LOOP;
END;
$$;

-- demand_charges
-- code = plan1 ~ plan20
INSERT INTO demand_charges (plan_id, ampere_from, ampere_to, charge)
SELECT id, amp, amp, amp * 10
FROM plans, (VALUES (10), (20), (30), (40), (50), (60)) AS amperages(amp)
WHERE code LIKE 'plan%' AND CAST(SUBSTRING(code, 5) AS INTEGER) BETWEEN 1 AND 20;

-- code = plan21 ~ plan40
INSERT INTO demand_charges (plan_id, ampere_from, ampere_to, charge)
SELECT id, 10, 10, 100
FROM plans
WHERE code LIKE 'plan%' AND CAST(SUBSTRING(code, 5) AS INTEGER) BETWEEN 21 AND 40;

-- code = plan41 ~ plan60
INSERT INTO demand_charges (plan_id, ampere_from, ampere_to, charge)
SELECT id, amp, amp, amp * 10
FROM plans, (VALUES (10), (20), (30)) AS amperages(amp)
WHERE code LIKE 'plan%' AND CAST(SUBSTRING(code, 5) AS INTEGER) BETWEEN 41 AND 60;

-- code = plan61 ~ plan80
INSERT INTO demand_charges (plan_id, ampere_from, ampere_to, charge)
SELECT id, amp, amp, amp * 10
FROM plans, (VALUES (40), (50), (60)) AS amperages(amp)
WHERE code LIKE 'plan%' AND CAST(SUBSTRING(code, 5) AS INTEGER) BETWEEN 61 AND 80;

-- code = plan81 ~ plan100
INSERT INTO demand_charges (plan_id, ampere_from, ampere_to, charge)
SELECT id, amp, amp, amp * 10
FROM plans, (VALUES (10), (20), (30), (40), (50), (60)) AS amperages(amp)
WHERE code LIKE 'plan%' AND CAST(SUBSTRING(code, 5) AS INTEGER) BETWEEN 81 AND 100;

-- code = plan81 ~ plan100 with special condition
INSERT INTO demand_charges (plan_id, ampere_from, ampere_to, charge)
SELECT id, 60, 490, 1000
FROM plans
WHERE code LIKE 'plan%' AND CAST(SUBSTRING(code, 5) AS INTEGER) BETWEEN 81 AND 100;

-- energy_charges
INSERT INTO energy_charges (plan_id, kwh_from, kwh_to, rate)
SELECT id, 0, 120, 10 FROM plans
UNION ALL
SELECT id, 120, 300, 20 FROM plans
UNION ALL 
SELECT id, 300, NULL, 30 FROM plans;