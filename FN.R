FN <- function(N){
        if (N==1 | N == 0){
                return(1)
        }else{
                return(FN(N-1)+FN(N-2))
        }
}

FN(7)
