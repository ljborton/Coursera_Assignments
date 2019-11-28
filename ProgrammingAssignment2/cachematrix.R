## Cachematrix writes a pair of functions (makecacheMatrix and 
##cacheSolve) that cache the inverse of a matrix

## makeCacheMatrix creates a special "matrix" object that can cache its 
##inverse.

makeCacheMatrix <- function(x = matrix()) {
        inv<-NULL
        set<-function(y) {
                x <<- y
                inv <<- NULL
        }
        get <- function() x
        setinverse <- function(solve) inv <<- solve
        getinverse <- function() inv
        list(set=set, get=get, setinverse=setinverse, getinverse=getinverse)
}


## cacheSolve computes the inverse of the special "matrix" returned by 
##makeCacheMatrix  above. If the inverse has already been calculated (and 
##the matrix has not changed), then  cacheSolve  should retrieve the inverse 
##from the cache.  The input of cacheSolve is actually makeCacheMatrix x,
##not just x

cacheSolve <- function(x, ...) {
        inv <- x$getinverse()
        if(!is.null(inv)) {
                message("getting cached data")
                return(inv)
        }
        data <- x$get()
        inv <- solve(data)
        x$setinverse(inv)
        inv
}

