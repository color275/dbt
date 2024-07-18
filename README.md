# python 환경 구성
- dbt 외 필요한 lib 추가 설치
```bash
python3.10 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install dbt-core
pip install dbt-redshift
pip install psycopg2
pip install faker
pip install python-dotenv
```

dbt 설치
```bash
dbt init myfirstdbt
``````
![](2024-07-17-00-35-21.png)

dbt profile 확인
```bash
cat /Users/ken/.dbt/profiles.yml
```
![](2024-07-17-00-35-50.png)

### DBT <-> DW 연결 확인
```bash
cd myfirstdbt
dbt debug
```
![](./img/2024-07-16-23-08-38.png)
![](./img/2024-07-16-23-08-51.png)

### VSCode Extensions
1. Power User for dbt Core 설치
   ![](./img/2024-07-17-00-45-01.png)

2. DBT 연결
   ![](./img/2024-07-17-09-00-15.png)
   ![](./img/2024-07-17-09-01-05.png)

3. Extension 기능
   ![](./img/2024-07-17-09-14-15.png)