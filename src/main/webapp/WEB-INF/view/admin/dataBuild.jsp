<%--
  Created by IntelliJ IDEA.
  User: gimdong-yun
  Date: 2024. 8. 29.
  Time: 오후 4:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>fucking todo - 카테고리 데이터 db 연결후 비동기 통신 받아오기</title>

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
    <!-- 1, 2, 5, 6번 박스는 10%의 높이 -->
    <div class="box" style="flex: 1 1 50%; height: 10vh;">
        <span>welcome 노예~~</span>
        <button onclick="getDataId()">데이터 id 가져오기</button>
        <button onclick="getRndDataId()">랜덤 데이터 id 가져오기(권장)</button>
    </div>
    <div id="dataIdArea" class="box" style="flex: 1 1 50%; height: 10vh;">

    </div>



    <!-- 3, 4번 박스는 나머지 공간을 차지 -->
    <div class="box" style="flex: 1 1 50%; height: 80vh;">
        <p id="dataArea"></p>
    </div>
    <div class="box" style="flex: 1 1 50%; height: 80vh; flex-direction: column">
        <button onclick="getCategorys()">카테고리 새로고침 (필요시)</button>
        <div class="row">
            <label for="main_category">main_category:</label>
            <select name="main_category" id="main_category" class="selectpicker" data-live-search="true"></select>
        </div>

        <div class="row">
            <label for="category">category:</label>
            <select name="category" id="category" class="selectpicker" data-live-search="true"></select>
        </div>

        <div class="row">
            <label for="project_category">project_category:</label>
            <select name="project_category" id="project_category" class="selectpicker" data-live-search="true"></select>
        </div>

        <div class="row">
            <label for="qualifications_skill">qualifications_skill_level:</label>
            <select name="qualifications_skill" id="qualifications_skill" class="selectpicker" data-live-search="true"></select>
        </div>
        <!-- 새로운 아이템이 나타날 영역 -->
        <div id="selectedItemsArea"></div>

        <div class="row">
            <label for="qualifications_option">qualifications_option:</label>
            <select name="qualifications_option" id="qualifications_option" class="selectpicker" data-live-search="true"></select>
        </div>
        <div id="selectedItemsArea2"></div>
        <div class="row">
            <label for="preferred_option">preferred_option:</label>
            <select name="preferred_option" id="preferred_option" class="selectpicker" data-live-search="true"></select>
        </div>
        <div id="selectedItemsArea3"></div>

        <div class="row">
            <label for="preferred_year">preferred_year:</label>
            <select name="preferred_year" id="preferred_year" class="selectpicker" data-live-search="true"></select>
        </div>


        <button onclick="makeResultData()">생성하기</button>
    </div>

    <!-- 5, 6번 박스는 10%의 높이 -->
    <div class="box" style="flex: 1 1 50%; height: 10vh;">5</div>
    <div class="box" style="flex: 1 1 50%; height: 10vh;">6</div>
</div>
<div id="newCategory" class="box" style="flex: 1 1 50%; height: 90vh;flex-direction: column">
    <h5>새로운 카테고리 추가</h5>
    <select name="main_category" id="new_category" class="selectpicker" data-live-search="true"></select>
    <input type="text"  id="value" placeholder="신중히 입역" name="value" required>
    <button onclick="newCategory()">카테고리 새로 넣기</button>

    <br>
    <hr>
    <br>
    <p id="result">

        <!-- 서버에 보내기전 여기에 결과가 나타남. -->

    </p>

    <button onclick="sendToServer()">서버로 보내기</button>


</div>

<!-- JavaScript -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"></script>
<script>
    let MdataId;

    const myArray = ['main_category', 'category', 'project_category', 'qualifications_skill', 'preferred_option', 'qualifications_option'];

    const selectElement = document.getElementById('new_category');

    let resultData=null;

    function sendToServer(){
        //2번 div에 있는 숫자 가져오기
        let dataId = document.getElementById('dataIdArea').innerText;
        fetch('/data/insert-data?id='+dataId, {
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
    function makeResultData(){

        resultData = {
            main_category: document.getElementById('main_category').value,
            category: document.getElementById('category').value,
            project_category: document.getElementById('project_category').value,
            qualifications_skill: selected_qualifications_skill,
            qualifications_option: selected_qualifications_option,
            preferred_option: selected_preferred_option,
            preferred_year: document.getElementById('preferred_year').value
        }

        document.getElementById('result').innerText = JSON.stringify(resultData, null, 4);
        console.log(resultData);
    }


    function newCategory(){
        let value = document.getElementById('value').value;
        let tableName = selectElement.value;
        console.log("value:", value);
        console.log("tableName:", tableName);
        fetch(`/data/insert-category?tableName=`+tableName+`&categoryName=`+value)
            .then(response => {
                console.log("response:", response);
                return response.json();
            })
            .then(result => {
                console.log("categorys:", result);

                getCategorys();
            })
            .catch(error => {
                console.log("error:", error);
            });
    }

    // 배열의 각 값을 드롭다운의 옵션으로 추가
    myArray.forEach(item => {
        const option = document.createElement('option'); // 새로운 옵션 생성
        option.value = item; // 옵션의 값 설정
        option.text = item;  // 옵션의 텍스트 설정
        selectElement.add(option); // 옵션을 드롭다운에 추가
    });

    function getCategorys(){
        fetch(`/data/category/all`)
            .then(response => {
                console.log("response:", response);
                return response.json();
            })
            .then(categorys => {
                // 기존 데이터를 초기화 (preferred_year 제외)
                dropdownItems.main_category = [];
                dropdownItems.category = [];
                dropdownItems.project_category = [];
                dropdownItems.qualifications_skill = [];
                dropdownItems.preferred_option = [];
                dropdownItems.qualifications_option = [];

                // 서버에서 불러온 데이터를 각각의 배열에 추가
                const mainCategories = categorys['mainCategoryList'];
                const categoryList = categorys['categoryList'];
                const projectCategories = categorys['projectCategoryList'];
                const qualificationsSkills = categorys['qualificationsSkillList'];
                const preferredOptions = categorys['preferredOptionList'];
                const qualificationsOptions = categorys['qualificationsOptionList'];

                mainCategories.forEach(category => dropdownItems.main_category.push(category.name));
                categoryList.forEach(category => dropdownItems.category.push(category.name));
                projectCategories.forEach(category => dropdownItems.project_category.push(category.name));
                qualificationsSkills.forEach(skill => dropdownItems.qualifications_skill.push(skill.name));
                preferredOptions.forEach(option => dropdownItems.preferred_option.push(option.name));
                qualificationsOptions.forEach(option => dropdownItems.qualifications_option.push(option.name));


                // 각 드롭다운 메뉴를 업데이트하고 selectpicker 새로고침
                updateDropdown('main_category', dropdownItems.main_category);
                updateDropdown('category', dropdownItems.category);
                updateDropdown('project_category', dropdownItems.project_category);
                updateDropdown('qualifications_skill', dropdownItems.qualifications_skill);
                updateDropdown('preferred_option', dropdownItems.preferred_option);
                updateDropdown('qualifications_option', dropdownItems.qualifications_option);

                console.log("Dropdown items updated:", dropdownItems);
            })
            .catch(error => {
                console.log("error:", error);
            });
    }

    function getDataId(){
        fetch('/data/get-data-id')
            .then(response => response.text())
            .then(dataId => {
                MdataId = dataId;
                console.log("MdataId:" + MdataId);
                document.getElementById('dataIdArea').innerText = dataId;
                getData(dataId);
            })
            .catch(error => {
                console.log("error:" + error);
            });
    }
    function getRndDataId(){
        fetch('/data/get-rnd-data-id')
            .then(response => response.text())
            .then(dataId => {
                MdataId = dataId;
                console.log("MdataId:" + MdataId);
                document.getElementById('dataIdArea').innerText = dataId;
                getData(dataId);
            })
            .catch(error => {
                console.log("error:" + error);
            });
    }

    function getData(dataId){
        fetch('/data/get-data?id=' + dataId)
            .then(response => response.text())
            .then(data2 => {
                document.getElementById('dataArea').innerText = data2;
            })
            .catch(error => {
                console.log("error:" + error);
            });

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
        main_category: [],
        category: [],
        project_category: [],
        qualifications_skill: [],
        preferred_option: [],
        qualifications_option: [],
        preferred_year: ["신입", "경력"] // 이 배열은 유지됩니다.

    };

    let selected_qualifications_skill = [];

    // 새로운 배열 선언: qualifications_option과 preferred_option
    let selected_qualifications_option = []; // 새로 추가한 배열
    let selected_preferred_option = []; // 새로 추가한 배열

    function handleSkillChange(event) {
        const selectedValue = event.target.value;
        if (selectedValue !== "선택필수" && !selected_qualifications_skill.some(skill => skill.startsWith(selectedValue))) {
            selected_qualifications_skill.push(selectedValue);

            const selectedItemsArea = document.getElementById('selectedItemsArea');

            const itemContainer = document.createElement('div');
            itemContainer.className = 'selected-item';
            const itemIndex = selected_qualifications_skill.length - 1; // 현재 항목의 인덱스
            itemContainer.dataset.index = itemIndex; // 고유 인덱스를 dataset 속성에 저장

            const div = document.createElement('div');
            div.textContent = selectedValue;
            div.id = 'skill-text-' + itemIndex;  // 고유 ID를 할당하여 나중에 참조

            const numberInput = document.createElement('input');
            numberInput.type = 'number';
            numberInput.min = 1;
            numberInput.max = 5;
            numberInput.step = 1;
            numberInput.style.width = '40px';

            numberInput.addEventListener('change', () => { // 숫자가 변경될 때마다 함수 실행
                const newText = selectedValue + "/" + numberInput.value;
                selected_qualifications_skill[itemIndex] = newText;
                
                document.getElementById('skill-text-' + itemIndex).textContent = newText;
                console.log(document.getElementById('skill-text-' + itemIndex))
                console.log(selected_qualifications_skill);
            });

            const removeButton = document.createElement('button');
            removeButton.textContent = '삭제';
            removeButton.className = 'remove-btn';
            removeButton.onclick = () => {
                selected_qualifications_skill.splice(itemIndex, 1);
                itemContainer.remove();
                console.log(selected_qualifications_skill);
            };

            itemContainer.appendChild(div);
            itemContainer.appendChild(numberInput);
            itemContainer.appendChild(removeButton);
            selectedItemsArea.appendChild(itemContainer);
        }
    }

    // 새로 추가한 함수: handleOptionChange
    function handleOptionChange(event, selectedItemsArray, idPrefix, targetAreaId) {
        const selectedValue = event.target.value;
        if (selectedValue !== "선택필수" && !selectedItemsArray.includes(selectedValue)) {
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
    }
    
    function getCategorys(){
        fetch(`/data/category/all`)
            .then(response => {
                console.log("response:", response);
                return response.json();
            })
            .then(categorys => {
                // 기존 데이터를 초기화 (preferred_year 제외)
                dropdownItems.main_category = [];
                dropdownItems.category = [];
                dropdownItems.project_category = [];
                dropdownItems.qualifications_skill = [];
                dropdownItems.preferred_option = [];
                dropdownItems.qualifications_option = [];

                // 서버에서 불러온 데이터를 각각의 배열에 추가
                const mainCategories = categorys['mainCategoryList'];
                const categoryList = categorys['categoryList'];
                const projectCategories = categorys['projectCategoryList'];
                const qualificationsSkills = categorys['qualificationsSkillList'];
                const preferredOptions = categorys['preferredOptionList'];
                const qualificationsOptions = categorys['qualificationsOptionList'];

                mainCategories.forEach(category => dropdownItems.main_category.push(category.name));
                categoryList.forEach(category => dropdownItems.category.push(category.name));
                projectCategories.forEach(category => dropdownItems.project_category.push(category.name));
                qualificationsSkills.forEach(skill => dropdownItems.qualifications_skill.push(skill.name));
                preferredOptions.forEach(option => dropdownItems.preferred_option.push(option.name));
                qualificationsOptions.forEach(option => dropdownItems.qualifications_option.push(option.name));


                // 각 드롭다운 메뉴를 업데이트하고 selectpicker 새로고침
                updateDropdown('main_category', dropdownItems.main_category);
                updateDropdown('category', dropdownItems.category);
                updateDropdown('project_category', dropdownItems.project_category);
                updateDropdown('qualifications_skill', dropdownItems.qualifications_skill);
                updateDropdown('preferred_option', dropdownItems.preferred_option);
                updateDropdown('qualifications_option', dropdownItems.qualifications_option);

                console.log("Dropdown items updated:", dropdownItems);
            })
            .catch(error => {
                console.log("error:", error);
            });
    }

    // 드롭다운 항목을 초기화
    window.onload = function () {
        updateDropdown('preferred_year', dropdownItems.preferred_year);
        getCategorys();

        // qualifications_skill 이벤트 리스너 추가
        document.getElementById('qualifications_skill').addEventListener('change', handleSkillChange);

        // 새로 추가한 이벤트 리스너
        document.getElementById('qualifications_option').addEventListener('change', function(event) {
            handleOptionChange(event, selected_qualifications_option, 'qualifications-option', 'selectedItemsArea2');
        });

        document.getElementById('preferred_option').addEventListener('change', function(event) {
            handleOptionChange(event, selected_preferred_option, 'preferred-option', 'selectedItemsArea3');
        });
    };
</script>

</body>
</html>
