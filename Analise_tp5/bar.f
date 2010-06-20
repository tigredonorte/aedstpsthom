      subroutine DecomposicaoLU(n, Det, Pivot, A)

          !definicoes
          real*8, dimension (1:n,1:n)::A
          real*8, dimension (1:n)::Pivot
          real*8 Det, Amax, r, m
          integer p,t

          do i = 1, n, 1
              Pivot(i) = i
          end do
          Det = 1

          do j = 1, n, 1
              p = j;
              Amax = abs(A(j,j))

              do k = j+1, n, 1
                   if(abs(A(k,j)) .GT. Amax) then
                       Amax = abs(A(k,j))
                       p = k
                   endif
              end do

              if(p .NE. j) then
                  do k = 1, n, 1
                      t = A(j,k)
                      A(j,k) = A(p,k)
                      A(p,k) = t
                  end do

                  t = Pivot(j);
                  Pivot(j) = Pivot(p)
                  Pivot(p) = t
                  Det = -Det
              endif

              Det = Det * A(i,j)
              if(abs(A(k,j)) .NE. 0) then
                  r = 1/A(j,j)
                  do i = j + 1, n, 1
                      m = A(i,j)*r
                      A(i,j) = m

                      do k = j + 1, n, 1
                          A(i,k) = A(i,k) - m * A(j,k)
                      end do
                  end do
              endif
          end do
          Det = Det*A(n,n)
	  end subroutine DecomposicaoLU

      subroutine SubstituicoesSucessivasPivotal(n, L, c, Pivot, y)

          !definicoes
          real*8, dimension (1:n,1:n)::L
          real*8, dimension (1:n)::Pivot, y, c
          real*8 soma
          integer k

          k = Pivot(1)
          y(1) = c(k)
          do i = 2, n, 1
              soma = 0
              do j = 1, i-1, 1
                  soma = soma + L(i,j)*y(j)
              end do
              k = Pivot(i)
              y(i) = c(k) - soma
          end do

	  end subroutine SubstituicoesSucessivasPivotal

      subroutine SubstituicoesRetroativas(n, U, y, x)

          !definicoes
          real*8, dimension (1:n,1:n)::U
          real*8, dimension (1:n)::y, x
          real*8 soma

          x(n) = y(n)/U(n,n)
          do i = 1, n, 1
              soma = 0
              do j = 1, i-1, 1
                  soma = soma + U(i,j)*x(j)
              end do
              x(i) = (y(i) - soma)/U(i,i)
          end do
        

	  end subroutine SubstituicoesRetroativas
      
      subroutine GetMatrizL(n, A, L)
          !definicoes
          real*8, dimension (1:n,1:n)::A, L

          !copia a matriz inferior de A, seta 1 nas diagonais e 0 na matriz superior
          do i = 1, n, 1
              do j = 1, n, 1
                 if(i .GT. j) then
                     L(i,j) = A(i,j)
                 end if

                 if(i .LT. j) then
                     L(i,j) = 0
                 end if

                 if(i .EQ. j) then
                     L(i,j) = 1
                 end if
              end do
          end do

	  end subroutine GetMatrizL

      subroutine GetMatrizU(n, A, U)
          !definicoes
          real*8, dimension (1:n,1:n)::A, L

          !copia a matriz superior de A e 0 na matriz inferior
          do i = 1, n, 1
              do j = 1, n, 1

                 L(i,j) = A(i,j)
                 if(i .GT. j) then
                     L(i,j) = 0
                 end if
              end do
          end do

	  end subroutine GetMatrizU
      
      subroutine NormaEuclidiana(n, b, A, x, r, norma)
          !definicoes
          real*8, dimension (1:n,1:n)::A
          real*8, dimension (1:n)::b, x, r
          real*8 acumula, norma

          do i = 1, n, 1
              do k = 1, n, 1
                  acumula = acumula + A(i,k)*x(k)
              end do
              r(i) = acumula
          end do

          do i = 1, n, 1
              r(i) = (b(i) - r(i))
              norma = sqrt(r(i)*r(i))
          end do

	  end subroutine NormaEuclidiana

      subroutine SalvaResultados(n, A, Det, y, x, r, Norma)
          !definicoes
          real*8, dimension (1:n,1:n)::A
          real*8, dimension (1:n)::y, x, r
          real*8 Det, Norma
          integer, parameter :: arqOut = 11

          !salva os calculos
          open(arqOut, file="resultado.dat") !abre o arquivo

          write (arqOut, *) "Matriz A decomposta:"
          do i = 1, n, 1
            write (arqOut, *) (A(i, j), j=1, n)
          end do

          write (arqOut, *)
          write (arqOut, *)
          write (arqOut, *) "Determinante de A: "
          write (arqOut, *) Det

          write (arqOut, *)
          write (arqOut, *)
          write (arqOut, *) "Vetor y (substituicoes sucessivas)"
          write (arqOut, *) (y(i), j=1, n)

          write (arqOut, *)
          write (arqOut, *)
          write (arqOut, *) "Vetor x (substituicoes retroativas)"
          write (arqOut, *) (x(i), j=1, n)

          write (arqOut, *)
          write (arqOut, *)
          write (arqOut, *) "Vetor residuo R"
          write (arqOut, *) (r(i), j=1, n)

          write (arqOut, *)
          write (arqOut, *)
          write (arqOut, *) "Norma euclidiana de R"
          write (arqOut, *) Norma

          close(arqOut)

	  end subroutine SalvaResultados
     