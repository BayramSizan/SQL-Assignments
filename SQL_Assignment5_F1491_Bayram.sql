
/*


Factorial Function

Create a scalar-valued function that returns the factorial of a number you gave it.


*/

-- first try to find the factorial code.

DECLARE
				@counter int,
				@number_ INT,
				@factorial INT
			set @counter = 1
			set @number_ = 9
			set @factorial = @counter
					while @counter <= @number_
						begin
							set @factorial = @factorial * @counter
							set @counter = @counter + 1
						end
					print @factorial
;


-- it is time to create a function
CREATE FUNCTION fnc_factorial (
								@number_ INT
							  )
RETURNS int
AS
BEGIN
DECLARE
				@counter int,
				@factorial INT
			set @counter = 1
			set @factorial = @counter
					while @counter <= @number_
						begin
							set @factorial = @factorial * @counter
							set @counter = @counter + 1
						end
return @factorial
END
;


-- it is time to use this function.
SELECT dbo.fnc_factorial(9);

SELECT dbo.fnc_factorial(0);

SELECT dbo.fnc_factorial(3);

SELECT dbo.fnc_factorial(-3);