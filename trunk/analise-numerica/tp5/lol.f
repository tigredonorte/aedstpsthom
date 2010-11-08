        PROGRAM TRANSPOSTA

           ! DEFINIÇÃO DE VARIÁVEIS
           INTEGER :: I, J, NLIN, NCOL,TNLIN, TNCOL
           REAL :: MATRIZ(3, 3), TRANSPOST(3, 3)
           READ (*, *) NLIN, NCOL
           READ (*, *) ((MATRIZ(I, J), J = 1, NCOL, 1), I = l, NLIN)

           ! CHAMADA DA SUB-ROTINA
           CALL TRANSP(NLIN, NCOL, MATRIZ, TNLIN, TNCOL, TRANSPOST)
           WRITE(*, *) "MATRIZ LIDA:"
           DO I = 1, NLIN, 1
              WRITE(*, *) (MATRIZ(I, J), J = l, NCOL, 1)
           END DO

           WRITE(*, *) "MATRIZ TRANSPOSTA:"

           DO I = 1, TNLIN, 1
              WRITE(*, *) (TRANSPOST(I, J), J = 1, TNCOL, 1)
           END DO

           STOP

        END PROGRAM TRANSPOSTA

        ! SUB-ROTINA
        SUBROUTINE TRANSP(M, N, MAT, MT, NT, MATTRANS)
           IMPLICIT NONE
           INTEGER :: M, N, MT, NT, I, J
           REAL :: MAT (M, N) , MATTRANS(N, M)

           DO I = 1, M, 1
              DO J = 1, N, 1
                 MATTRANS(J, I) = MAT(I, J)
              END DO
           END DO

           MT = N
           NT = M
           RETURN
        END SUBROUTINE TRANSP
