<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>몽고 유저 데이터 만들기</title>

    <!-- 부트스트랩 4 CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Select CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css" rel="stylesheet">

    <!-- 커스텀 CSS -->
    <style>
        body {
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            width: 100%;
            height: 100vh;
        }

        .box {
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #ffffff;
            border: 1px solid #ddd;
            font-size: 18px;
            font-weight: bold;
            color: #333;
            box-sizing: border-box;
        }

        #dataArea {
            width: 100%;
            height: 100%;
            overflow-y: auto;
            padding: 10px;
            box-sizing: border-box;
        }

        .row {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .row label {
            margin-right: 10px;
        }

        #selectedItemsArea {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }

        .selected-item {
            display: flex;
            align-items: center;
            margin-top: 5px;
        }

        .remove-btn {
            margin-left: 10px;
            background-color: #f44336;
            color: white;
            border: none;
            padding: 2px 5px;
            cursor: pointer;
            font-size: 12px;
        }

        /* 추가 스타일 */
        .bootstrap-select .dropdown-menu {
            max-height: 200px;
            overflow-y: auto;
        }
    </style>
</head>
<body>


<div class="container">
    <!-- 3, 4번 박스는 나머지 공간을 차지 -->
    <div class="box" style="flex: 1 1 50%; height: 80vh;">
        <p id="result" style="width: 100%">
            <!-- 서버에 보내기전 여기에 결과가 나타남. -->
        </p>
    </div>
    <div class="box" style="flex: 1 1 50%; height: 80vh; flex-direction: column">
        <div class="row">
            <label for="Language">Language:</label>
            <select name="Language" id="Language" class="selectpicker" data-live-search="true"></select>
        </div>
        <div id="selectedItemsArea"></div>
        <div class="row">
            <label for="Framework">Framework:</label>
            <select name="Framework" id="Framework" class="selectpicker" data-live-search="true"></select>
        </div>
        <div id="selectedItemsArea2"></div>
        <div class="row">
            <label for="SQL">SQL:</label>
            <select name="SQL" id="SQL" class="selectpicker" data-live-search="true"></select>
        </div>
        <div id="selectedItemsArea3"></div>
        <div class="row">
            <label for="NoSQL">NoSQL:</label>
            <select name="NoSQL" id="NoSQL" class="selectpicker" data-live-search="true"></select>
        </div>
        <!-- 새로운 아이템이 나타날 영역 -->
        <div id="selectedItemsArea4"></div>

        <div class="row">
            <label for="DevOps">DevOps:</label>
            <select name="DevOps" id="DevOps" class="selectpicker" data-live-search="true"></select>
        </div>
        <div id="selectedItemsArea5"></div>
        <div class="row">
            <label for="Service">Service:</label>
            <select name="Service" id="Service" class="selectpicker" data-live-search="true"></select>
        </div>
        <div id="selectedItemsArea6"></div>
        <div class="row">
            <label for="Qualifications">Service:</label>
            <select name="Qualifications" id="Qualifications" class="selectpicker" data-live-search="true"></select>
        </div>
        <div id="selectedItemsArea7"></div>
        <div class="row">
            <label for="Linguistics">Service:</label>
            <select name="Linguistics" id="Linguistics" class="selectpicker" data-live-search="true"></select>
        </div>
        <div id="selectedItemsArea8"></div>
        <%--      <div class="row">
                  <label for="Qualifications">Qualifications:</label>
                  <div id="Qualifications" class="checkbox-group">
                      <!-- 자바스크립트에서 체크박스 추가 -->
                  </div>
              </div>
              <div id="selectedItemsArea7"></div>

              <div class="row">
                  <label for="Linguistics">Linguistics:</label>
                  <div id="Linguistics" class="checkbox-group">
                      <!-- 자바스크립트에서 체크박스 추가 -->
                  </div>
              </div>
              <div id="selectedItemsArea8"></div>
      --%>

        <div style="width: 100%;display: flex; flex-direction: row; justify-content: space-between;">
            <button class="btn btn-success" onclick="makeResultData()">데이터 확인 하기</button>
            <button class="btn btn-danger" onclick="sendToServer()">생성하기</button>
        </div>
    </div>

</div>



<!-- JavaScript -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"></script>
<script>
    let MdataId;

    const myArray = ['Language', 'Framework', 'SQL', 'NoSQL', 'DevOps', 'Service'];

    const selectElement = document.getElementById('new_category');

    let resultData = null;

    const userId = ${user.id};
    console.log('userId', userId);

    function sendToServer(){
        fetch('/analystic/create', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(resultData),
        })
            .then(response => response.text())
            .then(data => {
                if (data === "success") {
                    console.log('Success');
                    //getRndDataId();
                    //getCategorys();
                } else {
                    console.log('Unexpected response:');
                }
            })
            .catch((error) => {
                console.error('Error:', error);
            });
    }

    function makeResultData() {
        resultData =
            {
                id: null,
                user_id: userId,
                Language: selected_Language.length > 0 ? selected_Language : {},
                Framework: selected_Framework.length > 0 ? selected_Framework : {},
                SQL: selected_SQL.length > 0 ? selected_SQL : {},
                NoSQL: selected_NoSQL.length > 0 ? selected_NoSQL : {},
                DevOps: selected_DevOps.length > 0 ? selected_DevOps : {},
                Service: selected_Service.length > 0 ? selected_Service : {},
                qualification: selected_Qualifications.length > 0 ? selected_Qualifications : "false",
                linguistics: selected_Linguistics.length > 0 ? selected_Linguistics : "false"
            }

        document.getElementById('result').innerText = JSON.stringify(resultData, null, 4);
        console.log(resultData);
    }
    function updateDropdown(dropdownId, items) {
        const dropdown = document.getElementById(dropdownId);
        dropdown.innerHTML = ''; // 기존 옵션들을 제거

        items.forEach(item => {
            const option = document.createElement('option');
            option.value = item;
            option.text = item;
            dropdown.add(option);
        });

        // 선택 항목 업데이트 후 selectpicker 새로고침
        $('#' + dropdownId).selectpicker('refresh');
    }

    const dropdownItems = {
        Language: {},
        Framework: {},
        SQL: {},
        NoSQL: {},
        DevOps: {},
        Service: {},
        Qualifications: {},
        Linguistics: {}
    };

    // 각 필드의 선택 항목을 저장할 배열 (user_skill)
    let selected_Language = [];
    let selected_Framework = [];
    let selected_SQL = [];
    let selected_NoSQL = [];
    let selected_DevOps = [];
    let selected_Service = [];

    // 각 필드의 선택 항목을 저장할 배열 (qualifications)
    let selected_Qualifications = [];

    // 각 필드의 선택 항목을 저장할 배열 (linguistics)
    let selected_Linguistics = [];

    // 하나의 이벤트 핸들러로 모든 필드를 처리할 수 있도록 수정
    function handleSkillChange(event, selectedItemsArray, targetAreaId) {
        const selectedValue = event.target.value;
        if (selectedValue !== "선택필수" && !selectedItemsArray.some(item => item.startsWith(selectedValue))) {
            const itemIndex = selectedItemsArray.length;
            selectedItemsArray.push(selectedValue);

            const selectedItemsArea = document.getElementById(targetAreaId);

            const itemContainer = document.createElement('div');
            itemContainer.className = 'selected-item';
            itemContainer.dataset.index = itemIndex;

            const div = document.createElement('div');
            div.textContent = selectedValue;
            div.id = targetAreaId+ '-text-' + itemIndex;
            div.style.fontSize = '15px';
            //div.style.width = '10px';
            //div.style.height = '10px';


            const numberInput = document.createElement('input');
            numberInput.type = 'number';
            numberInput.min = 1;
            numberInput.max = 5;
            numberInput.step = 1;
            numberInput.style.width = '40px';

            // 선택한 기술과 레벨을 결합하여 업데이트
            numberInput.addEventListener('change', () => {
                const newText = selectedValue + '/' + numberInput.value;
                selectedItemsArray[itemIndex] = newText;

                document.getElementById(targetAreaId+ '-text-' + itemIndex).textContent = newText;
                console.log(selectedItemsArray);
            });

            const removeButton = document.createElement('button');
            removeButton.textContent = '삭제';
            removeButton.className = 'remove-btn';
            removeButton.onclick = () => {
                selectedItemsArray.splice(itemIndex, 1);
                itemContainer.remove();
                console.log(selectedItemsArray);
            };

            itemContainer.appendChild(div);
            itemContainer.appendChild(numberInput);
            itemContainer.appendChild(removeButton);
            selectedItemsArea.appendChild(itemContainer);
        }
    }

    function handleOptionChange(event, selectedItemsArray, idPrefix, targetAreaId) {
        const selectedValue = event.target.value;
        selectedItemsArray.push(selectedValue);
        console.log(selectedItemsArray);
        const selectedItemsArea = document.getElementById(targetAreaId);

        const itemContainer = document.createElement('div');
        itemContainer.className = 'selected-item';
        const itemIndex = selectedItemsArray.length - 1;
        itemContainer.dataset.index = itemIndex;

        const div = document.createElement('div');
        div.textContent = selectedValue;
        div.id = `${idPrefix}-text-${itemIndex}`;

        const removeButton = document.createElement('button');
        removeButton.textContent = '삭제';
        removeButton.className = 'remove-btn';
        removeButton.onclick = () => {
            selectedItemsArray.splice(itemIndex, 1);
            itemContainer.remove();
            console.log(selectedItemsArray);
        };

        itemContainer.appendChild(div);
        itemContainer.appendChild(removeButton);
        selectedItemsArea.appendChild(itemContainer);

    }
    function handleSkillSelection(event, selectedItemsArray, targetAreaId) {
        const selectedValue = event.target.value;
        const selectedItemsArea = document.getElementById(targetAreaId);

        // 이미 선택된 항목이 있는지 확인
        const itemIndex = selectedItemsArray.findIndex(item => item.value === selectedValue);

        if (selectedValue !== "선택필수") {
            if (itemIndex === -1) {
                // 선택된 경우 true로 처리
                selectedItemsArray.push(selectedValue);

                const itemContainer = document.createElement('div');
                itemContainer.className = 'selected-item';

                const div = document.createElement('div');
                div.textContent = selectedValue;
                itemContainer.appendChild(div);

                const removeButton = document.createElement('button');
                removeButton.textContent = '삭제';
                removeButton.className = 'remove-btn';
                removeButton.onclick = () => {
                    selectedItemsArray.splice(itemIndex, 1); // 배열에서 항목 제거
                    itemContainer.remove();
                    console.log(selectedItemsArray);
                };

                itemContainer.appendChild(removeButton);
                selectedItemsArea.appendChild(itemContainer);
            } else {
                // 이미 선택된 항목이 클릭된 경우 아무 이벤트도 발생하지 않도록 처리
                event.target.value = "선택필수"; // 기본값으로 되돌리기
            }
        }
    }

    window.onload = function () {
        getCategorys();

        // 각 필드에 이벤트 리스너 추가
        document.getElementById('Language').addEventListener('change', function(event) {
            handleSkillChange(event, selected_Language, 'selectedItemsArea');
        });

        document.getElementById('Framework').addEventListener('change', function(event) {
            handleSkillChange(event, selected_Framework, 'selectedItemsArea2');
        });

        document.getElementById('SQL').addEventListener('change', function(event) {
            handleSkillChange(event, selected_SQL, 'selectedItemsArea3');
        });

        document.getElementById('NoSQL').addEventListener('change', function(event) {
            handleSkillChange(event, selected_NoSQL, 'selectedItemsArea4');
        });

        document.getElementById('DevOps').addEventListener('change', function(event) {
            handleSkillChange(event, selected_DevOps, 'selectedItemsArea5');
        });

        document.getElementById('Service').addEventListener('change', function(event) {
            handleSkillChange(event, selected_Service, 'selectedItemsArea6');
        });

        document.getElementById('Qualifications').addEventListener('change', function(event) {
            handleSkillSelection(event, selected_Qualifications, 'selectedItemsArea7');
        });

        document.getElementById('Linguistics').addEventListener('change', function(event) {
            handleSkillSelection(event, selected_Linguistics, 'selectedItemsArea8');
        });
    };

    function getCategorys(){
        fetch(`/data/mongo/category`)
            .then(response => {
                console.log("response:", response);
                return response.json();
            })
            .then(categorys => {
                // 기존 데이터를 초기화
                dropdownItems.Language = [];
                dropdownItems.Framework = [];
                dropdownItems.SQL = [];
                dropdownItems.NoSQL = [];
                dropdownItems.DevOps = [];
                dropdownItems.Service = [];
                dropdownItems.Qualifications = [];
                dropdownItems.Linguistics = [];

                console.log("Received categorys data:", categorys);
                // 서버에서 불러온 데이터를 각각의 배열에 추가
                const LanguageList = categorys['languageList'];
                const FrameworkList = categorys['frameworkList'];
                const SQLList = categorys['SQLList'];
                const NoSQLList = categorys['NoSQLList'];
                const DevOpsList = categorys['devOpsList'];
                const ServiceList = categorys['serviceList'];
                const QualificationsList = categorys['qualificationsList'];
                const LinguisticsList = categorys['linguisticList'];

                LanguageList.forEach(category => dropdownItems.Language.push(category.name));
                FrameworkList.forEach(category => dropdownItems.Framework.push(category.name));
                SQLList.forEach(category => dropdownItems.SQL.push(category.name));
                NoSQLList.forEach(skill => dropdownItems.NoSQL.push(skill.name));
                DevOpsList.forEach(option => dropdownItems.DevOps.push(option.name));
                ServiceList.forEach(option => dropdownItems.Service.push(option.name));
                QualificationsList.forEach(category => dropdownItems.Qualifications.push(category.name));
                LinguisticsList.forEach(category => dropdownItems.Linguistics.push(category.name));

                // 각 드롭다운 메뉴를 업데이트하고 selectpicker 새로고침
                updateDropdown('Language', dropdownItems.Language);
                updateDropdown('Framework', dropdownItems.Framework);
                updateDropdown('SQL', dropdownItems.SQL);
                updateDropdown('NoSQL', dropdownItems.NoSQL);
                updateDropdown('DevOps', dropdownItems.DevOps);
                updateDropdown('Service', dropdownItems.Service);
                updateDropdown('Qualifications', dropdownItems.Qualifications);
                updateDropdown('Linguistics', dropdownItems.Linguistics);

                console.log("Dropdown items updated:", dropdownItems);
            })
            .catch(error => {
                console.log("error:", error);
            });
    }


</script>

</body>
</html>
