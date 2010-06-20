      program main
          !declaraçoes das variaveis
          integer n, abriu
          integer, parameter :: arqIn = 10
          real*8, dimension (:,:), allocatable :: A, L, U
          real*8, dimension (:), allocatable :: b, Pivot, y, x, r
          real*8 Det, norma
          
          !abre o arquivo (fopen)
          open(arqIn, file="matriz.dat", status="old", iostat=abriu ) !abre o arquivo(ele deve existir no diretorio para nao dar erro)
          if(abriu .NE. 0) then
              stop
          endif

          !leitura do arquivo (fgets)
          read(arqIn, *) n !leitura dos argumentos

          !alocacao de memoria
          allocate (A(1:n,1:n))
          allocate (L(1:n,1:n))
          allocate (U(1:n,1:n))
          allocate (b(1:n))
          allocate (Pivot(1:n))
          allocate (y(1:n))
          allocate (x(1:n))
          allocate (r(1:n))
          read (arqIn, *) ((A(i, j), j=1, n), i = 1, n)
          read (arqIn, *) (b(i), i=1, n)
          close(arqIn)


          !chamada das funcoes
          call DecomposicaoLU(n, Det, Pivot, A)
          call GetMatrizL(n, A, L)
          call SubstituicoesSucessivasPivotal(n, L, b, Pivot, y)
          call GetMatrizU(n, A, U)
          call SubstituicoesRetroativas(n, U, y, x)
          call NormaEuclidiana(n, b, A, x, r, norma)
          call SalvaResultados(n, A, Det, y, x, r, Norma)

          !libera memoria
          deallocate(y)
          deallocate(x)
          deallocate(A)
          deallocate(L)
          deallocate(U)
          deallocate(b)
          deallocate(r)
          deallocate(Pivot)
          

      stop !para a execução do programa
      end !fim do programa
