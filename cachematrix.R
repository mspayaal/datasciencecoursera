## These two functions are used to get the inverse of a matrix.  
## If the matrix vector has not changed the cached value is used. 

## This function is used to get and set the vector and its inverse

makeCacheMatrix <- function(x = matrix()) {
        m <- NULL
        set <- function(y){
                x <<- y
                m <<- NULL
        }
        get <-function() x
        setinverse <- function(solve)m <<- solve 
        getinverse <- function() m
        list(set = set,get= get,
             setinverse = setinverse,
             getinverse = getinverse)
}


## This function isused to calcualte the inverse

cacheSolve <- function(x, ...) {
        m <- x$getinverse()
        if(!is.null(m)){
                message("getting cached data")
                return(m)
        }
        data <- x$get()
        m <- solve(data,...)
        x$setinverse(m)
        m
        ## Return a matrix that is the inverse of 'x'
}
