<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!-- header.jsp  -->
<%@ include file="/WEB-INF/view/layout/lightHeader.jsp"%>
<!-- css -->
<link rel="stylesheet" href="/css/myInfo.css">

<div id="skillModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2 id="modalSkillName"></h2>
        <div id="modalSkillLevels"></div>
        <div id="modalEditSection"></div>
    </div>
</div>

<style>
    .modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.4);
    }
    .modal-content {
        background-color: #fefefe;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
        height: 80%;
        border-radius: 10px;
        /* model 속성 무효 */
        display: block;
    }
    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }
    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }

    /* 추가 */
    .row{
        margin: 0;
    }
    .remove-btn{
        border: none;
        border-radius: 20px;
        background-color: darkred;
        color: white;
    }
    .modalEditSection{
        margin-top: 10px;
    }
</style>

<title>나의 스킬</title>

<section class="user--section">
    <aside class="personal--bar">
        <div class="bar--items">
            <p>내 정보</p>
            <a href="#" class="bar--selected">계정관리</a>
            <a href="/user/my-subscribe">구독 내역</a>
            <a href="/user/mySkillPage">스킬스택 관리</a>

        </div>
        <div class="bar--items">
            <p>포트폴리오</p>
            <a href="/user/my-portfolio">포트폴리오</a>
        </div>
    </aside>

    <div class="form-group skill-container">
        <ul class="skill-list">
            <c:forEach var="skillMap" items="${userSkillList}">
                <c:forEach var="entry" items="${skillMap}">
                    <li>
                        <div class="skill-box">
                            <span class="skill-category">${entry.key}</span>

                            <div class="skill-items">
                                <c:forEach var="skill" items="${entry.value}">
                                    <span class="skill-name">${skill.key}</span>
                                    <span class="skill-level">${skill.value}</span>
                                </c:forEach>
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </c:forEach>
        </ul>
    </div>

    <button id="saveChanges" style="display: none;" onclick="sendCreatedData()">저장</button>
</section>

<script>
    let skillBox = null;
    let skillCategory = '';
    let skillNameValue = '';
    let skillLevel = '';

    // 초기 값 설정


    const skillContainer = document.querySelector('.skill-container');

    const modal = document.getElementById('skillModal');
    const modalSkillName = document.getElementById('modalSkillName');
    const modalSkillLevels = document.getElementById('modalSkillLevels');

    skillContainer.addEventListener('click', function (event) {
        skillBox = event.target.closest('.skill-box');
        if (skillBox) {
            skillCategory = skillBox.querySelector('.skill-category')?.textContent.trim();
            console.log("Clicked Skill Category:", skillCategory)

            const skillNames = skillBox.querySelectorAll('.skill-name');
            const skillLevels = skillBox.querySelectorAll('.skill-level');
            console.log('skillNames', skillNames);
            console.log('skillLevels', skillLevels);
            // handleSkillChange(event, )
            console.log('Skill Category', skillCategory);

            let skills = [];
            let editSection = '';
            let index = 0;

            if(skillCategory === "Language") {
                index = 1;
            }
            if(skillCategory === "Framework") {
                index = 2;
            }
            if(skillCategory === "SQL") {
                index = 3;
            }
            if(skillCategory === "NoSQL") {
                index = 4;
            }
            if(skillCategory === "DevOps") {
                index = 5;
            }
            if(skillCategory === "Service") {
                index = 6;
            }
            if(skillCategory === "Qualification") {
                index = 7;
            }
            if(skillCategory === "Linguistic") {
                index = 8;
            }

            editSection +=
                '<div id="selectedItemsArea'
                + index
                + '"></div> <div class="row"> <label for="'
                + skillCategory
                + '">'
                + '스킬 추가'
                + '</label> <select name="'
                + skillCategory
                + '" id="'
                + skillCategory
                + '" class="selectpicker" data-live-search="true"></select> </div>'
                + '<button type="button" onclick=autoPushData()>';
            console.log('index', index);
            skillNames.forEach((skillName, skillIndex) => {
                const skillNameValue = skillNames[skillIndex].textContent;
                const skillLevel = skillLevels[skillIndex]?.textContent.trim();

                if (skillName && skillLevel) {
                    skills.push(skillName.textContent.trim() + ' : ' + skillLevel);
                    editSection +=
                        `<div><label>`
                        + skillName.textContent.trim()
                        + `</label><input type="number" min="1" max="5" value="`
                        + skillLevel
                        + `"/>`
                        + '<button class="remove-btn">삭제</button></div>';
                    index++;

                    console.log('skillNamevalue', skillNameValue);
                    console.log('skillLevels', skillLevels);
                    console.log('skillLevel', skillLevel);
                }
            });
            console.log(skillCategory);

            console.log('Get Category');
            modalSkillName.textContent = skillCategory ? skillCategory : 'No category';
            modalSkillLevels.textContent = skills.length > 0 ? skills.join(', ') : 'No skills available';
            document.getElementById('modalEditSection').innerHTML = editSection; // 수정 섹션 추가
            modal.style.display = 'block'; // 모달 표시
            // 저장 버튼 보이기
            console.log('qqqqqqq', document.getElementById(skillCategory));
            getCategorys(skillCategory);
            addDropdownEventListeners();
            document.getElementById('saveChanges').style.display = 'block';
            const removeButtons = document.querySelectorAll('.remove-btn');
            removeButtons.forEach((button) => {
                button.onclick = function() {
                    // 해당 스킬 항목 삭제
                    button.parentElement.remove();
                };
            });

            // 수정 입력 필드의 change 이벤트 리스너 추가
            const inputFields = document.querySelectorAll('.skill-item input[type="number"]');
            inputFields.forEach((inputField) => {
                inputField.addEventListener('change', function() {
                    const updatedSkillLevel = inputField.value;
                    console.log(`Updated skill level for ${inputField.previousElementSibling.textContent}: ${updatedSkillLevel}`);
                    // 필요한 경우 여기에서 배열을 업데이트
                });
            });
        }
    });

    function closeModal() {
        modal.style.display = 'none';
        autoPushData();
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = 'none';
        }
    }

    let selected_Language = [];
    let selected_Framework = [];
    let selected_SQL = [];
    let selected_NoSQL = [];
    let selected_DevOps = [];
    let selected_Service = [];
    let selected_Qualifications = [];
    let selected_Linguistics = [];

    function handleSkillChange(event, selectedItemsArray, targetAreaId) {
        const selectedValue = event.target.value;
        console.log('selectedValue : ', selectedValue);
        if (selectedValue !== "선택필수" && !selectedItemsArray.some(item => item.startsWith(selectedValue))) {
            const itemIndex = selectedItemsArray.length;
            selectedItemsArray.push(selectedValue);

            const selectedItemsArea = document.getElementById(targetAreaId);
            console.log('targetAreaId', selectedItemsArea);
            const itemContainer = document.createElement('div');
            itemContainer.className = 'selected-item';
            itemContainer.dataset.index = itemIndex;

            const div = document.createElement('div');
            div.textContent = selectedValue;
            div.id = targetAreaId + '-text-' + itemIndex;
            div.style.fontSize = '15px';

            const numberInput = document.createElement('input');
            numberInput.type = 'number';
            numberInput.min = 1;
            numberInput.max = 5;
            numberInput.style.width = '40px';
            console.log('targetAreaId', targetAreaId);
            console.log('numberInput', numberInput);
            console.log('itemIndex', itemIndex);
            numberInput.addEventListener('change', () => {
                const newText = selectedValue + '/' + numberInput.value;
                selectedItemsArray[itemIndex] = newText;
                document.getElementById(targetAreaId + '-text-' + itemIndex).textContent = newText;
            });

            const removeButton = document.createElement('button');
            removeButton.textContent = '삭제';
            removeButton.className = 'remove-btn';
            removeButton.onclick = () => {
                selectedItemsArray.splice(itemIndex, 1);
                itemContainer.remove();
            };

            itemContainer.appendChild(div);
            itemContainer.appendChild(numberInput);
            itemContainer.appendChild(removeButton);
            selectedItemsArea.appendChild(itemContainer);


        }
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

    function sendCreatedData() {
        makeResultData();
        console.log('zzz', resultData);
        sendToServer();

    }

    function sendToServer() {
        fetch('http://localhost:8080/analystic/create', {
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
                    location.reload(true);
                } else {
                    console.log('Unexpected response:');
                }
            })
            .catch((error) => {
                console.error('Error:', error);
            });
    }

    function makeResultData() {

        resultData = {
            Language: selected_Language.length > 0 ? selected_Language : [],
            Framework: selected_Framework.length > 0 ? selected_Framework : [],
            SQL: selected_SQL.length > 0 ? selected_SQL : [],
            NoSQL: selected_NoSQL.length > 0 ? selected_NoSQL : [],
            DevOps: selected_DevOps.length > 0 ? selected_DevOps : [],
            Service: selected_Service.length > 0 ? selected_Service : [],
            qualification: selected_Qualifications.length > 0 ? selected_Qualifications : [],
            linguistics: selected_Linguistics.length > 0 ? selected_Linguistics : []
        };

        console.log(resultData);
    }

    const dropdownItems = {
        Language: [],
        Framework: [],
        SQL: [],
        NoSQL: [],
        DevOps: [],
        Service: [],
        Qualifications: [],
        Linguistics: []
    };

    let categoryData = null;

    function getCategorys(skillName) {
        if (categoryData) {
            console.log('CateGoryggggg ', categoryData);
            console.log("Using cached category data.");
            updateDropdowns(categoryData);
            return;
        }

        fetch(`http://localhost:8080/data/mongo/category`)
            .then(response => {
                if (!response.ok) {
                    throw new Error("Network response was not ok");
                }
                return response.json();
            })
            .then(categorys => {
                categoryData = categorys; // 데이터를 전역 변수에 저장
                console.log("Received categorys data:", categorys);
                updateDropdowns(categorys); // 드롭다운 업데이트
            })
            .catch(error => {
                console.log("error:", error);
            });
    }
    function updateDropdowns(categorys) {
        if (!categorys) {
            console.log("No category data available");
            return; // 데이터를 받을 수 없을 경우 함수를 종료
        }

        const LanguageList = categorys['languageList'] || [];
        const FrameworkList = categorys['frameworkList'] || [];
        const SQLList = categorys['SQLList'] || [];
        const NoSQLList = categorys['NoSQLList'] || [];
        const DevOpsList = categorys['devOpsList'] || [];
        const ServiceList = categorys['serviceList'] || [];
        const QualificationsList = categorys['qualificationsList'] || [];
        const LinguisticsList = categorys['linguisticList'] || [];
        console.log('check2',LanguageList[0]);
        if (skillCategory === "Language") {
            console.log("check1");
            LanguageList.forEach(category => dropdownItems.Language.push(category.name));
            console.log('check3',LanguageList[0]);

            updateDropdown('Language', dropdownItems.Language);
        } else if (skillCategory === "Framework") {
            console.log('checkFramework')
            FrameworkList.forEach(category => dropdownItems.Framework.push(category.name));
            updateDropdown('Framework', dropdownItems.Framework);
            console.log('checkFramework')
        } else if (skillCategory === "SQL") {
            SQLList.forEach(category => dropdownItems.SQL.push(category.name));
            updateDropdown('SQL', dropdownItems.SQL);
        } else if (skillCategory === "NoSQL") {
            NoSQLList.forEach(skill => dropdownItems.NoSQL.push(skill.name));
            updateDropdown('NoSQL', dropdownItems.NoSQL);
        } else if (skillCategory === "DevOps") {
            DevOpsList.forEach(option => dropdownItems.DevOps.push(option.name));
            updateDropdown('DevOps', dropdownItems.DevOps);
        } else if (skillCategory === "Service") {
            ServiceList.forEach(option => dropdownItems.Service.push(option.name));
            updateDropdown('Service', dropdownItems.Service);
        } else if (skillCategory === "Qualification") {
            QualificationsList.forEach(category => dropdownItems.Qualifications.push(category.name));
            updateDropdown('Qualification', dropdownItems.Qualifications);
        } else if (skillCategory === "Linguistic") {
            console.log('Linguistic', skillCategory);
            LinguisticsList.forEach(category => dropdownItems.Linguistics.push(category.name));
            updateDropdown('Linguistic', dropdownItems.Linguistics);
        }

        console.log("Dropdown items updated:", dropdownItems);
    }


    function updateDropdown(dropdownId, items) {
        console.log('dropdownId', dropdownId);
        console.log('items', items);

        let dropdown = document.getElementById(dropdownId);
        console.log('dddddddd',dropdown);
        //dropdown.innerHTML = '';
        items.forEach(item => {
            const option = document.createElement('option');
            option.value = item;
            option.text = item;
            dropdown.add(option);
        });

        // jQuery 없이 selectpicker 리프레시할 경우 다른 방법으로 구현해야 함
        //  $('#'+dropdownId).selectpicker('refresh'); // 이 줄을 필요할 경우 추가하세요
    }

    // 이벤트 리스너 추가 함수
    function addDropdownEventListeners() {
        if (skillCategory === "Language") {
            console.log('languageElement Start');
            const languageElement = document.getElementById('Language');
            if (languageElement) {
                languageElement.addEventListener('change', function(event) {
                    handleSkillChange(event, selected_Language, 'selectedItemsArea1');
                    console.log(selected_Language);
                });
            }
        }
        if (skillCategory === "Framework") {
            console.log('frameworkElement Start');
            const frameworkElement = document.getElementById('Framework');
            if (frameworkElement) {
                frameworkElement.addEventListener('change', function(event) {
                    handleSkillChange(event, selected_Framework, 'selectedItemsArea2');
                });
            }
        }
        if (skillCategory === "SQL") {
            console.log('SQL Element Start');
            const sqlElement = document.getElementById('SQL');
            if (sqlElement) {
                sqlElement.addEventListener('change', function(event) {
                    handleSkillChange(event, selected_SQL, 'selectedItemsArea3');
                    console.log(selected_SQL.toString());
                });
            }
        }
        if (skillCategory === "NoSQL") {
            console.log('noSQL Element Start');
            const noSqlElement = document.getElementById('NoSQL');
            if (noSqlElement) {
                noSqlElement.addEventListener('change', function(event) {
                    handleSkillChange(event, selected_NoSQL, 'selectedItemsArea4');
                });
            }
        }
        if (skillCategory === "DevOps") {
            console.log('devOpsElement Start');
            const devOpsElement = document.getElementById('DevOps');
            if (devOpsElement) {
                devOpsElement.addEventListener('change', function(event) {
                    handleSkillChange(event, selected_DevOps, 'selectedItemsArea5');
                });
            }
        }
        if (skillCategory === "Service") {
            console.log('Service Element Start');
            const serviceElement = document.getElementById('Service');
            if (serviceElement) {
                serviceElement.addEventListener('change', function(event) {
                    handleSkillChange(event, selected_Service, 'selectedItemsArea6');
                });
            }
        }
        if (skillCategory === "Qualification") {
            console.log('Qualification Element Start');
            const qualificationElement = document.getElementById('Qualification');
            if (qualificationElement) {
                qualificationElement.addEventListener('change', function(event) {
                    handleSkillSelection(event, selected_Qualifications, 'selectedItemsArea7');
                });
            }
        }
        if (skillCategory === "Linguistic") {
            console.log('Linguistics Element Start');
            const linguisticElement = document.getElementById('Linguistic');
            if (linguisticElement) {
                linguisticElement.addEventListener('change', function(event) {
                    handleSkillSelection(event, selected_Linguistics, 'selectedItemsArea8');
                });
            }
        }
    }

    function autoPushData() {
        const skillNames = document.querySelectorAll('.skill-name');

        skillNames.forEach(skill => {
            console.log('znzn', skill.textContent); // 각 스킬 이름 출력
        });

        const skillBoxes = document.querySelectorAll('.skill-box');
        console.log('skillBoxes', skillBoxes);

        if (skillBoxes.length > 0) { // skill-box 요소가 존재하는지 확인
            skillBoxes.forEach((skillBox, index) => {
                console.log('SkillBox', index, skillBox);

                const skillCategory = skillBox.querySelector('.skill-category')?.textContent.trim();
                const skillNames = skillBox.querySelectorAll('.skill-name');
                const skillLevels = skillBox.querySelectorAll('.skill-level');

                skillNames.forEach((skillName, skillIndex) => {
                    const skillNameValue = skillName.textContent;
                    const skillLevel = skillLevels[skillIndex]?.textContent.trim();

                    console.log('skillNameValue', skillNameValue);
                    console.log('skillLevel', skillLevel);

                    const skillValue = skillNameValue + '/' + skillLevel;
                    console.log('skillValue', skillValue);

                    // 각 스킬 카테고리에 따른 배열에 추가
                    if(skillCategory === "Language") {
                        if (!selected_Language.includes(skillValue) && skillLevel !== null) {
                            selected_Language.push(skillValue);
                        }
                    } else if (skillCategory === "Framework") {
                        if (!selected_Framework.includes(skillValue)) {
                            selected_Framework.push(skillValue);
                        }
                    } else if (skillCategory === "SQL") {
                        if (!selected_SQL.includes(skillValue)) {
                            selected_SQL.push(skillValue);
                        }
                    } else if (skillCategory === "NoSQL") {
                        if (!selected_NoSQL.includes(skillValue)) {
                            selected_NoSQL.push(skillValue);
                        }
                    } else if (skillCategory === "Service") {
                        if (!selected_Service.includes(skillValue)) {
                            selected_Service.push(skillValue);
                        }
                    } else if (skillCategory === "Qualification") {
                        if (!selected_Qualifications.includes(skillValue)) {
                            selected_Qualifications.push(skillValue);
                        }
                    } else if (skillCategory === "Linguistic") {
                        if (!selected_Linguistics.includes(skillValue)) {
                            selected_Linguistics.push(skillValue);
                        }
                    }
                });
            });
        } else {
            console.error('No skill-box elements found.');
        }


        makeResultData();
    }
    window.onload = function() {
        autoPushData();
    }

    // DOMContentLoaded에서 getCategorys() 호출
    // document.addEventListener('DOMContentLoaded', function() {
    //     getCategorys();
    // });
</script>

<%@ include file="/WEB-INF/view/layout/lightFooter.jsp"%>