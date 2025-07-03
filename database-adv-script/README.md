# ALX Airbnb Database - Advanced SQL Scripts

This repository contains advanced SQL scripts and optimization techniques for the ALX Airbnb Database project. The project focuses on complex querying, performance optimization, indexing, and database administration skills.

## Project Structure

\`\`\`
database-adv-script/
├── schema.sql                              # Database schema definition
├── joins_queries.sql                       # Task 0: Complex JOIN queries
├── subqueries.sql                          # Task 1: Subquery implementations
├── aggregations_and_window_functions.sql   # Task 2: Aggregations and window functions
├── database_index.sql                      # Task 3: Index creation scripts
├── perfomance.sql                          # Task 4: Query optimization examples
├── partitioning.sql                        # Task 5: Table partitioning implementation
├── index_performance.md                    # Task 3: Index performance analysis
├── optimization_report.md                  # Task 4: Query optimization report
├── partition_performance.md                # Task 5: Partitioning performance report
├── performance_monitoring.md               # Task 6: Performance monitoring report
└── README.md                              # This file
\`\`\`

## Database Schema

The project uses a simplified Airbnb database schema with the following main entities:

- **User**: Stores user information (guests, hosts, admins)
- **Property**: Stores property listings
- **Booking**: Stores booking transactions
- **Review**: Stores property reviews and ratings
- **Payment**: Stores payment information

## Key Learning Objectives

1. **Complex SQL Queries**: Master INNER, LEFT, and FULL OUTER JOINs
2. **Subqueries**: Implement both correlated and non-correlated subqueries
3. **Aggregations**: Use GROUP BY, COUNT, SUM, AVG with window functions
4. **Performance Optimization**: Create indexes and optimize query execution
5. **Table Partitioning**: Implement partitioning for large datasets
6. **Performance Monitoring**: Use EXPLAIN, ANALYZE, and profiling tools

## Usage Instructions

1. **Setup Database**: Run `schema.sql` to create the database structure
2. **Load Sample Data**: Insert sample data for testing (not included in this repo)
3. **Execute Scripts**: Run each task script in order
4. **Monitor Performance**: Use the provided EXPLAIN queries to analyze performance
5. **Review Documentation**: Read the .md files for detailed analysis and reports

## Performance Testing

Before and after implementing optimizations, use these commands to measure performance:

\`\`\`sql
-- Enable query profiling
SET profiling = 1;

-- Run your queries here

-- View profiling results
SHOW PROFILES;
SHOW PROFILE FOR QUERY [query_id];
\`\`\`

## Best Practices Implemented

- **Indexing Strategy**: Indexes on frequently queried columns
- **Query Optimization**: CTEs, reduced subqueries, proper JOINs
- **Partitioning**: Date-based partitioning for time-series data
- **Performance Monitoring**: Regular analysis of query execution plans

## Tools and Techniques

- **EXPLAIN/ANALYZE**: Query execution plan analysis
- **Indexing**: B-tree indexes for optimal query performance
- **Partitioning**: Range partitioning by date
- **Window Functions**: Advanced analytical queries
- **CTEs**: Common Table Expressions for complex queries

## Contributing

This project is part of the ALX curriculum. Follow the project guidelines and submit your work according to the specified requirements.
