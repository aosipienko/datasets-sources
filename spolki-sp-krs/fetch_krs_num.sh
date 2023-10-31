#!/bin/bash

# Sprawdzenie, czy podano nazwę pliku jako argument
if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <file_with_company_names>"
	exit 1
fi

# Path to the file with company names
FILE_PATH="$1"

# Process each line (company name) in the file
while IFS= read -r COMPANY_NAME; do
	# Escape double quotes in the company name
	ESCAPED_COMPANY_NAME="${COMPANY_NAME//\"/\\\"}"
	PAYLOAD="{\"rejestr\":[\"P\",\"S\"],\"podmiot\":{\"krs\":null,\"nip\":null,\"regon\":null,\"nazwa\":\"$ESCAPED_COMPANY_NAME\",\"wojewodztwo\":null,\"powiat\":\"\",\"gmina\":\"\",\"miejscowosc\":\"\"},\"status\":{\"czyOpp\":null,\"czyWpisDotyczacyPostepowaniaUpadlosciowego\":null,\"dataPrzyznaniaStatutuOppOd\":null,\"dataPrzyznaniaStatutuOppDo\":null},\"paginacja\":{\"liczbaElementowNaStronie\":100,\"maksymalnaLiczbaWynikow\":100,\"numerStrony\":1}}"

	# echo "Fetching information for company: $ESCAPED_COMPANY_NAME..."
	# Execute the curl request with the current company name
	# echo "Payload: $PAYLOAD"
	RESPONSE=$(
		curl -sS 'https://prs-openapi2-prs-prod.apps.ocp.prod.ms.gov.pl/api/wyszukiwarka/krs' \
			-H 'Accept: application/json, text/plain, */*' \
			-H 'Accept-Language: pl;q=0.7' \
			-H 'Connection: keep-alive' \
			-H 'Content-Type: application/json' \
			-H 'Origin: https://wyszukiwarka-krs.ms.gov.pl' \
			-H 'Referer: https://wyszukiwarka-krs.ms.gov.pl/' \
			-H 'Sec-Fetch-Dest: empty' \
			-H 'Sec-Fetch-Mode: cors' \
			-H 'Sec-Fetch-Site: same-site' \
			-H 'Sec-GPC: 1' \
			-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36' \
			-H 'sec-ch-ua: "Chromium";v="118", "Brave";v="118", "Not=A?Brand";v="99"' \
			-H 'sec-ch-ua-mobile: ?0' \
			-H 'sec-ch-ua-platform: "macOS"' \
			-H 'x-api-key: TopSecretApiKey' \
			--data-raw "$PAYLOAD" \
			--compressed
	)
	echo "$RESPONSE" | jq -r '.listaPodmiotow[].numer'

	# sleep 1

done <"$FILE_PATH"
