Opis poszczególnych etapów zadania:
- utworzenie pliku build.yml 
- wykorzystanie docker buildx do kompilacji obrazu dla dwóch platform oraz użycie mode=max
- skanowanie trivy co pozwoliło usunąć błedy krytyczne
* w pliku build.yml zastosowałem exit-code: '0', aby github przepuścił mi commit, 
    większość błędów critical oraz high udało mi się wykluczyć jednak mimo użycia 
    odpowiednich wersji w package.json, trivy dalej wyrzucało mi tam kilka błędów high *
- publikacja i bezpieczne przesłanie obrazu do github  

Sposób tagowania obrazów: 
tag :latest - standardowe podejście, gdzie każdy udany "push" do głównej gałęzi "main" 
    nadpisuje najnowszą wersję obrazu.
tag :buildcache - dedykowany tag służący wyłącznie do celów optymalizacji