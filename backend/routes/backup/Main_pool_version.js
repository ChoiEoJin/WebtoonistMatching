var express = require('express');
var router = express.Router();
var objMatching = require('./obj/objMatching.js');
var db = require('./db/db.js');
var pool = require('./db/database');
//포폴리스트갖고오기
router.post('/PortfolioSelect',function(req,res,next){
console.log('메인포폴셀렉들어옴');
console.log('req.body ->',req.body);
var gen_number = req.body.gen_number;
console.log('req.body.gen_number ->',gen_number);

var FilterCondtions = {};

//parameter filtering 
if(gen_number == undefined){
    console.log('undefined 지만 전체로검색');
}else{
    if(gen_number == 0){
        console.log('전체');
    }else if(gen_number ==1){
        console.log('일상');
        FilterCondtions["g.gen_number"]=gen_number;
    }else if(gen_number ==2){
        console.log('로맨스');
        FilterCondtions["g.gen_number"]=gen_number;
    }else if(gen_number ==3){
        console.log('액션');
        FilterCondtions["g.gen_number"]=gen_number;
    }else if(gen_number ==4){
        console.log('개그');
        FilterCondtions["g.gen_number"]=gen_number;
    }else if(gen_number ==5){
        console.log('판타지');
        FilterCondtions["g.gen_number"]=gen_number;
    }else if(gen_number ==6){
        console.log('시대극');
        FilterCondtions["g.gen_number"]=gen_number;
    }else if(gen_number ==7){
        console.log('학원');
        FilterCondtions["g.gen_number"]=gen_number;
    }else if(gen_number ==8){
        console.log('멜로');
        FilterCondtions["g.gen_number"]=gen_number;
    }else if(gen_number ==9){
        console.log('스포츠');
        FilterCondtions["g.gen_number"]=gen_number;
    }else{
    
    }
}

if(gen_number !== undefined){//전체 검색이 아니라면,
    var sql = `insert into tb_analyst (search_gen_number) values (${gen_number})`;
    pool.query(sql,function(err01,data01,fields01){
        if(err01){
            console.log(err01);
            return;
        }else{
            console.log('analyst에 장르넘버추가완료');
            return;
        }
    });
}

//▼ 최소 옵션
FilterCondtions["p.po_open_yn"]='Y'; //공개글불러오기

objMatching.getAllportfolios(req,res,FilterCondtions); //암것도없으면 {'p.po_open_yn':'Y'}로넘어감

});


//상세보기
router.post('/PortfolioDetail',function(req,res,next){
    /*
        현재추가되는부분 상세보기누르면 해당포폴의 장르와 포폴번호가 analyst테이블에 추가됨
    */
 console.log('포폴상세보기진입성공');
 var po_number= req.body.po_number;
 var selectGenNumberSQL=`select gen_number from tb_portfolio where po_number =?`;
 pool.query(selectGenNumberSQL,[po_number],function(err01,data01,fields01){
        if(err01){
            console.log(err01);
            next();
        }else{
            var search_gen_number = data01[0].gen_number;
            var insertSQL=`insert into tb_analyst (search_gen_number,visited_po_number) values (?,?)`;
            pool.query(insertSQL,[search_gen_number,po_number],function(err02,data02,fields02){
                if(err02){
                    console.log(err02);
                }else{
                    next();
                }
            });
        }        
    });
 },function(req,res,next){
var po_number= req.body.po_number;
console.log('req.body.po_number ->',po_number);
var getViewCountSQL='select po_view_count from tb_portfolio where po_number=?';
pool.query(getViewCountSQL,[po_number],function(err,data,fileds){
        var NewViewCount = data[0].po_view_count +1 ;
        var updateViewCountSQL='update tb_portfolio set po_view_count=? where po_number=?';
        pool.query(updateViewCountSQL,[NewViewCount,po_number],function(err,data,fields){
            if(err){
                console.log('viewcount수정실패');
                next();
            }else{
                console.log('viewcount수정성공');
                console.log('newviewcount->',NewViewCount);
                next();
            }
        });
    });
},function(req,res,next){
    var po_number= req.body.po_number;
    console.log('req.body.po_number ->',po_number);
    var FilterCondtions = {};
    
    if(po_number == undefined){
    
    }else{
        FilterCondtions["p.po_number"]=po_number;
    }
    
    objMatching.getOneportfolio(req,res,FilterCondtions);

});

/*

DB 자동 재연결

*/































module.exports=router;