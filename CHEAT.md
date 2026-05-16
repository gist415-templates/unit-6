# PostGIS SQL Quick Reference

## Connecting

```bash
psql -h localhost -p 25432 -U postgres -d nyc
```

---

## Geometry Type Checks

```sql
SELECT ST_GeometryType(geom) FROM nyc_neighborhoods LIMIT 5;
SELECT ST_SRID(geom) FROM nyc_neighborhoods LIMIT 1;
```

---

## Spatial Relationships

```sql
-- Contains
SELECT a.name FROM neighborhoods a, boroughs b
WHERE ST_Contains(b.geom, a.geom) AND b.name = 'Brooklyn';

-- Intersects
SELECT a.name FROM streets a, neighborhoods b
WHERE ST_Intersects(a.geom, b.geom) AND b.name = 'Chelsea';

-- Within distance (meters, requires projected CRS)
SELECT name FROM nyc_subway_stations
WHERE ST_DWithin(geom, ST_GeomFromText('POINT(583571 4506714)', 26918), 500);
```

---

## Measurements

```sql
-- Length of a line (in CRS units — meters if projected)
SELECT ST_Length(geom) FROM nyc_streets WHERE name = 'Broadway' LIMIT 1;

-- Area of a polygon
SELECT name, ST_Area(geom) FROM nyc_neighborhoods ORDER BY ST_Area(geom) DESC;

-- Distance between two geometries
SELECT ST_Distance(a.geom, b.geom)
FROM nyc_subway_stations a, nyc_subway_stations b
WHERE a.name = 'Times Sq' AND b.name = 'Penn Station';
```

---

## Coordinate Reference Systems

```sql
-- Check SRID
SELECT ST_SRID(geom) FROM nyc_neighborhoods LIMIT 1;

-- Reproject on the fly (26918 = NAD83 / UTM zone 18N)
SELECT ST_Transform(geom, 4326) FROM nyc_neighborhoods LIMIT 1;

-- Find a CRS by name
SELECT * FROM spatial_ref_sys WHERE srtext ILIKE '%UTM zone 18N%';
```

---

## Spatial Joins

```sql
-- Count streets per neighborhood
SELECT n.name, COUNT(s.gid)
FROM nyc_neighborhoods n
JOIN nyc_streets s ON ST_Intersects(n.geom, s.geom)
GROUP BY n.name
ORDER BY COUNT(s.gid) DESC;
```

---

## Constructing Geometries

```sql
-- Point from WKT
SELECT ST_GeomFromText('POINT(-74.006 40.712)', 4326);

-- Buffer (distance in CRS units)
SELECT ST_Buffer(geom, 100) FROM nyc_subway_stations LIMIT 1;

-- Centroid
SELECT name, ST_Centroid(geom) FROM nyc_neighborhoods;

-- Convex hull
SELECT ST_ConvexHull(ST_Collect(geom)) FROM nyc_subway_stations;
```

---

## Table Info

```sql
-- List geometry columns
SELECT * FROM geometry_columns;

-- Row count
SELECT COUNT(*) FROM nyc_streets;

-- Column names
SELECT column_name, data_type FROM information_schema.columns
WHERE table_name = 'nyc_neighborhoods';
```

---

## Useful Functions

| Function | Description |
|---|---|
| `ST_GeomFromText(wkt, srid)` | Create geometry from WKT |
| `ST_AsText(geom)` | Return WKT representation |
| `ST_AsGeoJSON(geom)` | Return GeoJSON string |
| `ST_Transform(geom, srid)` | Reproject to target SRID |
| `ST_Collect(geom)` | Aggregate geometries into collection |
| `ST_Union(geom)` | Dissolve/union geometries |
| `ST_Simplify(geom, tolerance)` | Simplify with Douglas-Peucker |
| `ST_Extent(geom)` | Bounding box aggregate |
